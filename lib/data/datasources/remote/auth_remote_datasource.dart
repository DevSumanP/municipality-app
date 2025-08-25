import 'package:dio/dio.dart';
import 'package:municipality_app/core/constants/api_endpoints.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';
import 'package:municipality_app/core/network/dio_client.dart';

import '../../models/auth_model.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource({required this.dioClient});

  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await dioClient.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = response.data as Map<String, dynamic>;
      print('Response: Status=${response.statusCode}, Data=$responseData');

      if (response.statusCode == 200) {
        if (responseData.containsKey('success') &&
            responseData['success'] is bool &&
            responseData['success'] == true) {
          return AuthModel.fromJson(responseData);
        } else {
          final errorMessage = responseData.containsKey('message') &&
                  responseData['message'] != null
              ? responseData['message'].toString()
              : 'Login failed';
          print('Unauthorized Error: $errorMessage');
          throw AppException.unauthorized(errorMessage);
        }
      } else {
        final errorMessage = responseData.containsKey('message') &&
                responseData['message'] != null
            ? responseData['message'].toString()
            : 'Login failed';
        print('Server Error: $errorMessage');
        throw AppException.server(errorMessage);
      }
    } on DioException catch (e) {
      print(
          'DioException: Type=${e.type}, Status=${e.response?.statusCode}, Data=${e.response?.data}');
      if (e.response?.data != null && e.response!.data is Map) {
        final errorData = e.response!.data as Map<String, dynamic>;
        final errorMessage =
            errorData.containsKey('message') && errorData['message'] != null
                ? errorData['message'].toString()
                : 'Login failed';
        if (e.response?.statusCode == 401) {
          throw AppException.unauthorized(errorMessage);
        } else if (e.response?.statusCode == 422) {
          throw AppException.validation(errorMessage);
        } else {
          throw AppException.server(errorMessage);
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw AppException.network('Network timeout occurred');
      } else {
        throw AppException.network('Network error occurred');
      }
    }
  }

  Future<void> logout() async {
    try {
      await dioClient.post(ApiEndpoints.logout);
    } on DioException catch (_) {
      throw AppException.network('Logout failed');
    }
  }
}
