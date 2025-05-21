import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/failures/app_failure.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase) : super(const LoginState());

  Future<void> login(String username) async {
    if (username.isEmpty) {
      state = state.copyWith(validationError: AppStrings.pleaseEnterYourName);
      return;
    }
    state = state.copyWith(
      username: username,
      isLoading: true,
      errorMessage: null,
      validationError: null,
      isSuccess: false,
    );

    final Either<Failure, User> result = await loginUseCase(username);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message, isSuccess: false);
      },
      (user) {
        state = state.copyWith(username: username, isLoading: false, errorMessage: null, isSuccess: true);
      },
    );
  }
}
