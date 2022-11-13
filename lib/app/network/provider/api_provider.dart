import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:getx_with_ddd_modular/core/env.dart';
import 'package:getx_with_ddd_modular/presentation/core/sign_in/sign_in_ui.dart';
import 'package:getx_with_ddd_modular/utility/log/dio_logger.dart';
import 'package:getx_with_ddd_modular/utility/shared/constants/storage.dart';
import 'package:getx_with_ddd_modular/utility/shared/widgets/common_widget.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIProvider {
  static const String tag = 'APIProvider';
  static final String _baseUrl = Env.value.baseUrl + '/api';
  static final String _articleUrl = Env.value.articleUrl + '/api';

  late bool isConnected = false;
  late Dio _dio;
  late Dio _dioArticle;
  var tokenDio = Dio();
  String? token;
  late BaseOptions dioOptions;
  var storage = Get.find<SharedPreferences>();

  APIProvider() {
    dioOptions = BaseOptions()..baseUrl = APIProvider._baseUrl;
    dioOptions.validateStatus = (value) {
      return value! < 500;
    };

    BaseOptions articleBaseOption = BaseOptions(baseUrl: _articleUrl);

    _dio = Dio(dioOptions);
    _dioArticle = Dio(articleBaseOption);
    tokenDio.options = _dio.options;

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

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
      DioLogger.onSend(tag, options);
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
          Get.log('request token succeed, value: ' +
              response.data['data']['auth_token']);
          Get.log(
              'continue to perform request：path:${options.path}，baseURL:${options.path}');

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
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError dioError, handler) {
      DioLogger.onError(tag, dioError);

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
    };
  }

  Future<Response> postData(String path, dynamic data) async {
    try {
      var response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> postToken(String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> postFile(String path, FormData data) async {
    try {
      var response = await _dio.post(
        path,
        data: data,
        onSendProgress: (int sent, int total) {
          Get.log("Uploading ${(sent / total * 100)}%");
        },
      );
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> getData(String path) async {
    try {
      await addAuthorOpt();
      var response = await _dio.get(path);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> patchData(String path, dynamic data) async {
    try {
      var response = await _dio.patch(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> patchDataWithParams(String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.patch(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> deleteData(String path) async {
    try {
      var response = await _dio.delete(path);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> deleteDataWithParams(String path, dynamic data) async {
    try {
      var response = await _dio.delete(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> dasboardInformation(String path) async {
    try {
      await addAuthorOpt();
      var response = await _dio.get(path);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> authSocial(String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> getDataWithParams(
      String path, Map<String, dynamic> params) async {
    try {
      var response = await _dio.get(path, queryParameters: params);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> getArticleWithParams(String path) async {
    try {
      var response = await _dioArticle.get(path);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> putData(String path, dynamic data) async {
    try {
      await addAuthorOpt();
      var response = await _dio.put(path, data: data);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  void throwIfNoSuccess(DioError ex) async {
    if (ex.response!.statusCode! < 200 || ex.response!.statusCode! > 299) {
      Get.log("Gagal Oy");
      String errorMessage = json.decode(ex.response.toString())["error"] ??
          json.decode(ex.response.toString())["statusMessage"];
      Get.snackbar(
        'Oops..',
        errorMessage,
        backgroundColor: const Color(0xFF3F4E61),
      );
      throw Exception(errorMessage);
    }
  }

  Future<BaseOptions> addAuthorOpt() async {
    dioOptions.headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer ${storage.getString(StorageConstants.token)}',
      'Content-Type': 'application/json',
    };

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

  Future<Response> customGetData(
      {required String domain,
      required String path,
      Map<String, dynamic>? params}) async {
    try {
      await urlCustomOpt(domain);
      // final _dioExternal = Dio();
      var response = await _dio.get(path, queryParameters: params);
      await urlDefaultOpt();
      return response;
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
        child: const Text("Try Again"),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          onPrimary: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text("Close"),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          onPrimary: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.back();
      isConnected = false;
      noInternetWarning();
    } else {
      isConnected = true;
    }
  }

  Future<Response> postMedia(String path, dynamic data,
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
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> post(String path) async {
    try {
      var response = await _dio.post(path);
      return response;
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }
}
