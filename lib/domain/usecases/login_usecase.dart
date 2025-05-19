import 'package:either_dart/either.dart';

import '../../core/failures/app_failure.dart';
import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String username) {
    return repository.login(username);
  }
}
