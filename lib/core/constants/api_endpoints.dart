class ApiEndpoints {
  static const String baseUrl = 'https://dcc.progressnepal..com/api/v1';
  
  // Auth
  static const String login = '/login';
  static const String refresh = '/refresh';
  static const String logout = '/logout';
  
  // Data endpoints
  static const String services = '/services';
  static const String departments = '/departments';
  static const String employees = '/employees';
  static const String notices = '/notices';
  static const String scrollingNews = '/scrolling-news';
  static const String dashboardVideos = '/dashboard-videos';

  // Media
  static const String downloadMedia = '/media/doqnload';
  static const String uploadMedia = '/media/upload';
  
}