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
      authModel.data.expiresAt.toIso8601String(),
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
    try {
      print('🧹 Starting auth data cleanup...');
      
      // Remove all auth-related keys
      await localStorage.remove(StorageKeys.authData);
      await localStorage.remove(StorageKeys.accessToken);
      await localStorage.remove(StorageKeys.tokenExpiry);
      
      // Verify the data is actually cleared
      final tokenAfter = await localStorage.getString(StorageKeys.accessToken);
      final authDataAfter = await localStorage.getString(StorageKeys.authData);
      final expiryAfter = await localStorage.getString(StorageKeys.tokenExpiry);
      
      print('Token after clear: $tokenAfter');
      print('AuthData after clear: $authDataAfter'); 
      print('Expiry after clear: $expiryAfter');
      
      // Check if data is actually null or empty
      final isTokenCleared = tokenAfter == null || tokenAfter.isEmpty;
      final isAuthDataCleared = authDataAfter == null || authDataAfter.isEmpty;
      final isExpiryCleared = expiryAfter == null || expiryAfter.isEmpty;
      
      if (!isTokenCleared || !isAuthDataCleared || !isExpiryCleared) {
        print('WARNING: Auth data not fully cleared!');
        print('Token cleared: $isTokenCleared');
        print('AuthData cleared: $isAuthDataCleared');
        print('Expiry cleared: $isExpiryCleared');
        throw Exception('Failed to clear auth data completely');
      } else {
        print('Auth data successfully cleared');
      }
      
    } catch (e) {
      print('Error clearing the auth data: $e');
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    final authData = await getAuthData();
    return authData?.data.user;
  }
}
