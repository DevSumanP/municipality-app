class ApiEndpoints {
  // static const String baseUrl = 'https://dcc.progressnepal.com/api';

  static const String baseUrl = 'https://script.google.com/macros/s/AKfycbyFEzrFryH73n2lxyzIbIPNf5pRWXHiuVS1beVN1IDgIPwrb0kk1LZvXvH-8Qhop6Jw-w/exec?path=';

  
  // Auth
  static const String login = '/login';
  static const String refresh = '/refresh';
  static const String logout = '/logout';
  
  // Data endpoints
   static const String servicesCategories = 'api/servicecategories';
  static const String services = 'api/services';

  static const String newsArticles = 'api/newsarticles';
  static const String newsCategories = 'api/newscategories';
  static const String announcement = 'api/announcements';

  static const String emergencyContacts = 'api/emergencycontacts';
  static const String officeLocations = 'api/officelocations';
  static const String quickLinks = 'api/quicklinks';


  static const String departments = '';
  static const String employees = '/employees';
  static const String notices = '/notices';
  static const String scrollingNews = '/scrolling-news';
  static const String dashboardVideos = '/dashboard-videos';

  // Media
  static const String downloadMedia = '/media/doqnload';
  static const String uploadMedia = '/media/upload';
  
}