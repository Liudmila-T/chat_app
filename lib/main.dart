import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/presentation/screens/chat_screen.dart';
import 'package:chat_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/navigation_service.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.watch(navigationServiceProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      navigatorKey: navigationService.navigatorKey,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.login,
      routes: {Routes.login: (_) => const LoginScreen(), Routes.chat: (_) => const ChatScreen()},
    );
  }
}
