enum AppExceptionType {
  network,
  timeout,
  noInternet,
  unauthorized,
  forbidden,
  notFound,
  server,
  validation,
  database,
  storage,
  fileSystem,
  unknown,
  parsing;
}

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;
  final AppExceptionType type;

  const AppException(this.message,
      {this.code, this.data, this.type = AppExceptionType.unknown});

  // Network exceptions
  static AppException network(String message) => NetworkException(message);
  static AppException timeout(String message) => TimeoutException(message);
  static AppException noInternet(String message) =>
      NoInternetException(message);

  // HTTP exceptions
  static AppException unauthorized(String message) =>
      UnauthorizedException(message);
  static AppException forbidden(String message) => ForbiddenException(message);
  static AppException notFound(String message) => NotFoundException(message);
  static AppException server(String message) => ServerException(message);
  static AppException validation(String message) =>
      ValidationException(message);

  // Local exceptions
  static AppException database(String message) => DatabaseException(message);
  static AppException storage(String message) => StorageException(message);
  static AppException fileSystem(String message) =>
      FileSystemException(message);

  // Generic exceptions
  static AppException unknown(String message) => UnknownException(message);
  static AppException parsing(String message) => ParsingException(message);

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

// Network Exceptions
class NetworkException extends AppException {
  const NetworkException(super.message) : super(code: 'NETWORK_ERROR');
}

class TimeoutException extends AppException {
  const TimeoutException(super.message) : super(code: 'TIMEOUT_ERROR');
}

class NoInternetException extends AppException {
  const NoInternetException(super.message) : super(code: 'NO_INTERNET');
}

// HTTP Exceptions
class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message) : super(code: 'UNAUTHORIZED');
}

class ForbiddenException extends AppException {
  const ForbiddenException(super.message) : super(code: 'FORBIDDEN');
}

class NotFoundException extends AppException {
  const NotFoundException(super.message) : super(code: 'NOT_FOUND');
}

class ServerException extends AppException {
  const ServerException(super.message) : super(code: 'SERVER_ERROR');
}

class ValidationException extends AppException {
  const ValidationException(super.message) : super(code: 'VALIDATION_ERROR');
}

// Local Exceptions
class DatabaseException extends AppException {
  const DatabaseException(super.message) : super(code: 'DATABASE_ERROR');
}

class StorageException extends AppException {
  const StorageException(super.message) : super(code: 'STORAGE_ERROR');
}

class FileSystemException extends AppException {
  const FileSystemException(super.message) : super(code: 'FILESYSTEM_ERROR');
}

// Generic Exceptions
class UnknownException extends AppException {
  const UnknownException(super.message) : super(code: 'UNKNOWN_ERROR');
}

class ParsingException extends AppException {
  const ParsingException(super.message) : super(code: 'PARSING_ERROR');
}

/// Helper method to handle HTTP status codes consistently
AppException handleHttpStatusCode(int? statusCode, String resourceName) {
  switch (statusCode) {
    case 400:
      return AppException.validation('Invalid request for $resourceName');
    case 401:
      return AppException.unauthorized(
          'Authentication required to access $resourceName');
    case 403:
      return AppException.forbidden('Access to $resourceName is forbidden');
    case 404:
      return AppException.notFound('$resourceName not found');
    case 408:
      return AppException.timeout('Request timeout for $resourceName');
    case 422:
      return AppException.validation('Validation failed for $resourceName');
    case 429:
      return AppException.network('Too many requests. Please try again later.');
    case 500:
      return AppException.server('Internal server error occurred');
    case 502:
      return AppException.server('Bad gateway error');
    case 503:
      return AppException.server('Service temporarily unavailable');
    case 504:
      return AppException.timeout('Gateway timeout');
    default:
      return AppException.server(
          'Server error occurred${statusCode != null ? ' (Status: $statusCode)' : ''}');
  }
}
