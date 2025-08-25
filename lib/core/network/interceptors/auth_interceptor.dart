import 'package:dio/dio.dart';
import 'package:municipality_app/core/constants/storage_keys.dart';

import '../../storage/local_storage.dart';

class AuthInterceptor extends Interceptor{
  final LocalStorage _localStorage = LocalStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    // Add auth token to requests
    final token = await _localStorage.getString(StorageKeys.accessToken);
    if(token != null && token.isNotEmpty) {
       options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
   }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token expiry
    if(err.response?.statusCode == 401) {
      // Clear expired token
      await _localStorage.remove(StorageKeys.accessToken);
      await _localStorage.remove(StorageKeys.authData);

      // Trigger a refresh token flow or redirect to login
    }

    handler.next(err);
  }
}