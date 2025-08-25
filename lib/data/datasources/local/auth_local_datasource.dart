import '../../../core/storage/local_storage.dart';
import '../../../core/constants/storage_keys.dart';
import '../../models/auth_model.dart';
import 'dart:convert';

import '../../models/user_model.dart';

class AuthLocalDataSource {
  final LocalStorage localStorage;

  AuthLocalDataSource({required this.localStorage});

  Future<void> saveAuthData(AuthModel authModel) async {
    await localStorage.setString(
      StorageKeys.authData,
      jsonEncode(authModel.toJson()),
    );
    await localStorage.setString(
      StorageKeys.accessToken,
      authModel.data.accessToken,
    );
    await localStorage.setString(
      StorageKeys.tokenExpiry,
      authModel.data.expiresAt,
    );
  }

  Future<AuthModel?> getAuthData() async {
    final authDataString = await localStorage.getString(StorageKeys.authData);
    if (authDataString != null) {
      return AuthModel.fromJson(jsonDecode(authDataString));
    }
    return null;
  }

  Future<String?> getAccessToken() async {
    return await localStorage.getString(StorageKeys.accessToken);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    final expiry = await localStorage.getString(StorageKeys.tokenExpiry);
    
    if (token != null && expiry != null) {
      final expiryDate = DateTime.parse(expiry);
      return DateTime.now().isBefore(expiryDate);
    }
    return false;
  }

  Future<void> clearAuthData() async {
    await localStorage.remove(StorageKeys.authData);
    await localStorage.remove(StorageKeys.accessToken);
    await localStorage.remove(StorageKeys.tokenExpiry);
  }

  Future<User?> getCurrentUser() async {
    final authData = await getAuthData();
    return authData?.data.user;
  }
}