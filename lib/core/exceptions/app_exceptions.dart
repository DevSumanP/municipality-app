abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const AppException(this.message, {this.code, this.data});

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