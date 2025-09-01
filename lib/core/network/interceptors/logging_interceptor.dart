import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  String _truncateHeaderValues(Map<String, dynamic> headers) {
    return headers.map((key, value) {
      if (value is String && value.length > 10) {
        return MapEntry(key, '${value.substring(0, 10)}...');
      }
      return MapEntry(key, value);
    }).toString();
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      logger.i('REQUEST[$options.method}] => PATH: ${options.path}');
      logger.i('Query Parameters: ${options.queryParameters}');
      logger.i('Headers: ${_truncateHeaderValues(options.headers)}');
      if (options.data != null) {
        logger.i('Data: ${options.data}');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
     logger.d(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      logger.d('Data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      logger.e(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      logger.e('Error: ${err.message}');
      if (err.response?.data != null) {
        logger.e('Error Data: ${err.response?.data}');
      }
    }
    handler.next(err);
  }
}
