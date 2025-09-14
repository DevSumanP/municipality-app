import 'package:dio/dio.dart';

Exception handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return Exception('Connection timeout. Please try again.');
    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      if (statusCode == 404) {
        return Exception('Resource not found.');
      } else if (statusCode == 500) {
        return Exception('Server error. Please try again later.');
      }
      return Exception('Request failed with status: $statusCode');
    case DioExceptionType.cancel:
      return Exception('Request was cancelled.');
    case DioExceptionType.unknown:
    default:
      return Exception('Network error. Please check your connection.');
  }
}
