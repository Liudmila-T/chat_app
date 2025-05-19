import 'package:either_dart/either.dart';

import '../../core/failures/app_failure.dart';
import '../entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> login(String username);
}
