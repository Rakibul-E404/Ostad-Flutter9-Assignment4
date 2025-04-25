import 'dart:ui';

class AppConstants {
  static const String appName = 'Task Manager';
  static const String baseUrl = 'http://35.73.30.144:2005/api/v1';

  // SharedPreferences keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';

  // Statuses
  static const List<String> taskStatuses = [
    'New',
    'In Progress',
    'Completed',
  ];
}

class AppColors {
  static const Color primaryColor = Color(0xFF3F51B5);
  static const Color secondaryColor = Color(0xFF607D8B);
  static const Color accentColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
}