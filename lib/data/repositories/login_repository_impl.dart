import 'package:either_dart/either.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/failures/app_failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource remoteDatasource;

  LoginRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, User>> login(String username) async {
    try {
      final user = await remoteDatasource.login(username);
      return Right(user);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }
}
