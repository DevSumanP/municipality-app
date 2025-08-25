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

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data);
      } else {
        throw AppException.server('Login failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AppException.unauthorized('Invalid credentials');
      } else if (e.response?.statusCode == 422) {
        throw AppException.validation('Invalid input data');
      } else {
        throw AppException.network('Network error occurred');
      }
    } catch (e) {
      throw AppException.unknown('An unknown error occurred');
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
