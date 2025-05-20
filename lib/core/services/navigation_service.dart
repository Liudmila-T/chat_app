import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Routes {
  static const String login = '/login';
  static const String chat = '/chat';
}

final navigationServiceProvider = Provider<NavigationService>((ref) => NavigationService());

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> goToChat() => navigatorKey.currentState!.pushReplacementNamed(Routes.chat);
}
