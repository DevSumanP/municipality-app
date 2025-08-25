import 'user_model.dart';

class AuthModel {
  final bool success;
  final String message;
  final AuthData data;

  AuthModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AuthData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}

class AuthData {
  final User user;
  final String accessToken;
  final String tokenType;
  final String expiresAt;

  AuthData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      user: User.fromJson(json['user'] ?? {}),
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      expiresAt: json['expires_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_at': expiresAt,
    };
  }
}
