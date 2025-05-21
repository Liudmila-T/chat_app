import 'dart:io';

class AppConstants {
  static String get baseUrl => Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';

  static const String wsUrl = 'wss://echo.websocket.events';

  static const Duration connectionTimeout = Duration(seconds: 10);
}
