import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String username,
    @Default(false) bool isLoading,
    String? errorMessage,
    String? validationError,
    @Default(false) bool isSuccess,
  }) = _LoginState;
}
