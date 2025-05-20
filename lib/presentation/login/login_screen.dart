import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_strings.dart';
import '../../core/services/navigation_service.dart';
import '../widgets/app_text_field.dart';
import 'login_providers.dart';
import 'login_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  void _login() {
    final username = _usernameController.text.trim();
    ref.read(loginControllerProvider.notifier).login(username);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginControllerProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(AppStrings.loginSuccessful)));
        Future.delayed(const Duration(milliseconds: 800), () {
          ref.read(navigationServiceProvider).goToChat();
        });
      }

      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    final state = ref.watch(loginControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.login), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextField(
              controller: _usernameController,
              labelText: AppStrings.enterNameHint,
              errorText: state.validationError,
            ),
            const SizedBox(height: 40),
            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _login, child: const Text(AppStrings.login)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
