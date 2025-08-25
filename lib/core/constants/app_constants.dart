class AppConstants {
  static const String appName = 'Municipality App';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'municipality_app.db';
  static const int databaseVersion = 1;

  // Network
  static const int connectTimeout = 30000; 
  static const int receiveTimeout = 30000; 
  static const int sendTimeout = 30000;

  // File path
  static const String documentsFolder = 'documents';
  static const String imagesFolder = 'images';
  static const String videosFolder = 'videos';
  static const String thumbnailsFolder = 'thumbnails';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Sync Settings
  static const int syncInterval = 60 * 60; // 1 hour in seconds
  static const int maxSyncRetries = 3;

  // File Limits
  static const int maxImageSize = 5 * 1024 * 1024; // 5 MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50 MB
  static const int maxDocumentSize = 10 * 1024 * 1024; // 10 MB
}
