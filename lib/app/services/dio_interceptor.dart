import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:get/get.dart' as getx;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constrants.dart';
import '../routes/app_routes.dart';

class DioInterceptor extends Interceptor {
  final Logger _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
    _logger.d('Headers: ${options.headers}');
    _logger.d('Query Parameters: ${options.queryParameters}');
    _logger.d('Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    _logger.d('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.e(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    _logger.e('Error Message: ${err.message}');
    if (err.response != null) {
      _logger.e('Response Data: ${err.response?.data}');
    }

     if (err.response?.statusCode == 401) {
      _logoutUser();
    }
  
    super.onError(err, handler);
  }

  void _logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.ACCESS_TOKEN_KEY);
    await prefs.remove(AppConstants.USER_ROLE_KEY);
    await prefs.remove(AppConstants.USER_DATA_KEY);
    await prefs.remove(AppConstants.HAS_SEEN_GET_STARTED_KEY);

    getx.Get.offAllNamed(Routes.LOGIN);
    getx.Get.snackbar(
      "Session Expired",
      "Please log in again.",
      backgroundColor: Colors.red,
    );
  }
}
