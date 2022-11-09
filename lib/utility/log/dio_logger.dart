import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class DioLogger {
  static void onSend(String tag, RequestOptions options) {
    Get.log('header : ${options.headers}');
    Get.log(
        '$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}');
    Get.log('$tag - Request Data : ${options.data.toString()}');
  }

  static void onSuccess(
    String tag,
    Response response,
  ) {
    Get.log(
        '$tag - Request Path : [${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path} Request Data : ${response.requestOptions.data.toString()}');
    Get.log('$tag - Response statusCode : ${response.statusCode}');
    Get.log('$tag - Response data : ${response.data.toString()}');
  }

  static void onError(String tag, DioError error) {
    if (null != error.response) {
      Get.log(
          '$tag - Error Path : [${error.response!.requestOptions.method}] ${error.response!.requestOptions.baseUrl}${error.response!.requestOptions.path} Request Data : ${error.response!.requestOptions.data.toString()}');
      Get.log('$tag - Error statusCode : ${error.response!.statusCode}');
      Get.log(
          '$tag - Error data : ${null != error.response!.data ? error.response!.data.toString() : ''}');
    }

    if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      Get.log('No Internet');
    }
    Get.log('$tag - Error Message : ${error.message}');
  }
}
