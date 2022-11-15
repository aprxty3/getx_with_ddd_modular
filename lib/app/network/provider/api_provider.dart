import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/env.dart';
import '../../../feature/core/presentation/sign_in/sign_in_ui.dart';
import '../../../utility/shared/constants/storage.dart';
import '../../../utility/shared/widgets/common_widget.dart';
import '../../common/exception.dart';

enum TypeFile { image, video, audio, zip, docx, pdf, xls, pptx }

var uploadProgresFile = 0.0.obs;
var uploadProgresStories = 0.0.obs;

class APIProvider {
  static const String tag = 'APIProvider';

  static final String _baseUrl = '${Env.value.baseUrl}/api';

  // static final String _articleUrl = Env.value.articleUrl + '/api';
  // String baseUrl;

  late bool isConnected = false;
  late Dio _dio;
  var tokenDio = Dio();
  String? token;
  late BaseOptions dioOptions;
  late Directory dir;
  var storage = Get.find<SharedPreferences>();

  APIProvider() {
    Future.microtask(
        () async => dir = await getApplicationDocumentsDirectory());

    dioOptions = BaseOptions()..baseUrl = APIProvider._baseUrl;
    dioOptions.validateStatus = (value) {
      return value! < 500;
    };

    _dio = Dio(dioOptions);
    tokenDio.options = _dio.options;

    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };

    if (EnvType.development == Env.value.environmentType) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // DioLogger.onSend(tag, options);
      await checkConnectivity();
      if (storage.getString(StorageConstants.token) != null &&
          Jwt.isExpired(storage.getString(StorageConstants.token)!)) {
        Get.log(
            'isExpired Token : ${Jwt.isExpired(storage.getString(StorageConstants.token)!)}');
        Get.log(
            'refresh_token :${storage.getString(StorageConstants.refreshToken)}');
        Get.log('last Token :${storage.getString(StorageConstants.token)}');
        _dio.lock();

        await tokenDio.post('$_baseUrl/user/token/refresh', data: {
          "refresh_token": '${storage.getString(StorageConstants.refreshToken)}'
        }).then((response) async {
          Get.log(
              'request token succeed, value: ${response.data['data']['auth_token']}');
          Get.log(
              'continue to perform request：path: ${options.path}，baseURL:${options.path}');

          if (response.statusCode == 200) {
            var newToken = response.data['data']['auth_token'];
            storage.setString(StorageConstants.token, newToken);
            options.headers = {'Authorization': 'Bearer $newToken'};
            token = 'Bearer $newToken';
            handler.next(options);
          } else if (response.statusCode == 403) {
            var isNotForbiden = response.data['success'];
            if (!isNotForbiden) {
              CommonWidget.toast(
                  'Session Login has been expired, re-login please!');
              Get.offAllNamed(SignInUi.namePath);
              Get.find<SharedPreferences>().clear();
            }
          }
        }).catchError((error, stackTrace) {
          CommonWidget.toast(
              'Session Login has been expired, re-login please!');
          Get.offAllNamed(SignInUi.namePath);
          Get.find<SharedPreferences>().clear();
          handler.reject(error, true);
        }).whenComplete(() => _dio.unlock());
      } else {
        return handler.next(options);
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      // DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError dioError, handler) {
      // DioLogger.onError(tag, dioError);

      throwIfNoSuccess(dioError);
      return handler.next(dioError);
    }));

    // if you use ip dns server
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return null;
    };
  }

  Future<Either<GenericException, Response>> postData(
      String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.post(path, data: data);
      return Right(response);
    } on DioError catch (ex) {
      return Left(ServerRequestException(
          code: ExceptionCode.serverFailure,
          value: json.decode(ex.response.toString())["error"]));
      // throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> postToken(
      String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.post(path, data: data);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> uploadFile(String path,
      FormData data, Function(int sent, int total) onSendProgress) async {
    try {
      await addAuthorOpt();
      dioOptions.headers.addAll({'Content-Type': 'multipart/form-data'});
      final response = await _dio.post(path, data: data,
          onSendProgress: (int sent, int total) async {
        onSendProgress(sent, total);
        var proses = (sent / total) * 100;
        Get.log("$proses%");
        if (path.contains('stories')) {
          uploadProgresStories.value = proses;
          if (proses == 100) {
            await Future.delayed(const Duration(seconds: 4));
            uploadProgresStories.value = 0;
          }
        } else {
          uploadProgresFile.value = proses;
        }
      });
      return Right(response);
    } on DioError catch (ex) {
      CommonWidget.toast('Something went wrong for story post');
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> downloadFile(
      {required String url,
      required TypeFile type,
      required String fileName}) async {
    String path = '${dir.path}/Ai-Care/';

    switch (type) {
      case TypeFile.video:
        path += 'Video/$fileName.$type';
        break;
      case TypeFile.audio:
        path += 'Audio/$fileName.$type';
        break;
      case TypeFile.image:
        path += 'Images/$fileName.$type';
        break;
      case TypeFile.zip:
      case TypeFile.docx:
      case TypeFile.pdf:
      case TypeFile.xls:
      case TypeFile.pptx:
        path += 'Documents/$fileName.$type';
        break;
    }
    final response = await _dio.download(
      url,
      path,
      onReceiveProgress: (count, total) {
        Get.dialog(
          CircularProgressIndicator(
            value: count / total * 100,
            // Defaults to 0.5.
            valueColor: const AlwaysStoppedAnimation(Colors.pink),
            // Defaults to the current Theme's accentColor.
            backgroundColor: Colors.white,
            // Defaults to the current Theme's backgroundColor.
            color: Colors.red,
          ),
        );
      },
    );
    return Right(response);
  }

  Future<Either<GenericException, Response>> getData(String path) async {
    try {
      await addAuthorOpt();
      var response = await _dio.get(path);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> deleteData(String path) async {
    try {
      var response = await _dio.delete(path);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> deleteDataWithParams(
      String path, dynamic data) async {
    try {
      var response = await _dio.delete(path, queryParameters: data);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> dasboardInformation(
      String path) async {
    try {
      await addAuthorOpt();
      var response = await _dio.get(path);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> authSocial(
      String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.post(path, data: data);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> getDataWithParams(
      String path, Map<String, dynamic> params) async {
    try {
      await addAuthorOpt();
      var response = await _dio.get(path, queryParameters: params);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> putData(
      String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.put(path, data: data);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> patchData(
      String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.patch(path, data: data);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> patchDataWithParams(
      String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.patch(path, data: data);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  void throwIfNoSuccess(DioError ex) async {
    try {
      if (ex.error.statusCode! < 200 || ex.response!.statusCode! > 299) {
        Get.log("Gagal Oy");
        String errorMessage = json.decode(ex.response.toString())["error"] ??
            json.decode(ex.response.toString())["message"];
        Get.snackbar(
          'Oops..',
          errorMessage,
          backgroundColor: const Color(0xFF3F4E61),
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      Get.log('api $e');
    }
  }

  Future<BaseOptions> addAuthorOpt() async {
    // if (Env.value.articleUrl == baseUrl) {
    //   dioOptions.headers = {
    //     'X-Platfom': 'api',
    //     'Accept': 'application/json',
    //     'Content-Type': 'application/json',
    //   };
    // } else
    {
      dioOptions.headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer ${storage.getString(StorageConstants.token)}',
        'Content-Type': 'application/json',
      };
    }
    Get.log('header : ${dioOptions.headers}');
    return dioOptions;
  }

  Future<BaseOptions> urlCustomOpt(String url) async {
    dioOptions.baseUrl = url;
    return dioOptions;
  }

  Future<BaseOptions> urlDefaultOpt() async {
    dioOptions.baseUrl = _baseUrl;
    return dioOptions;
  }

  Future<Either<GenericException, Response>> customGetData(
      {required String domain,
      required String path,
      Map<String, dynamic>? params}) async {
    try {
      await urlCustomOpt(domain);
      // final _dioExternal = Dio();
      var response = await _dio.get(path, queryParameters: params);
      await urlDefaultOpt();
      return Right(response);
    } on DioError catch (ex) {
      // urlDefaultOpt();
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  noInternetWarning() async {
    await Get.defaultDialog(
      title: "No Internet",
      titlePadding: const EdgeInsets.all(20),
      titleStyle: const TextStyle(fontSize: 14),
      contentPadding: const EdgeInsets.only(bottom: 20, left: 14, right: 14),
      middleText: "Please check your connectivity!",
      middleTextStyle: const TextStyle(
        fontSize: 10,
      ),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
        child: const Text("Try Again"),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
        child: const Text("Close"),
      ),
    );
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Get.back();
      isConnected = false;
      //noInternetWarning();
    } else {
      isConnected = true;
    }
  }

  Future<Either<GenericException, Response>> postMedia(
      String path, dynamic data,
      {required String titleProgress}) async {
    try {
      var response = await _dio.post(path, data: data,
          onSendProgress: (int sent, int total) {
        Get.log("Uploading ${(sent / total * 100)}%");
        var percentage = sent / total * 100;
        if (percentage < 98) {
          Get.log(
              "${percentage / 100}, status: $titleProgress... ${percentage.toInt()}");
        }
      }, onReceiveProgress: (count, total) {
        Get.log("${100 / 100}, status: '$titleProgress... ${100}%");
      });
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Either<GenericException, Response>> post(String path) async {
    try {
      var response = await _dio.post(path);
      return Right(response);
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }
}
