import 'package:dio/dio.dart';

import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/user.dart';

abstract class LoginRemoteDatasource {
  Future<User> login(String username);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final Dio dio;

  LoginRemoteDatasourceImpl(this.dio);

  @override
  Future<User> login(String username) async {
    try {
      final response = await dio.post('/login', data: {'username': username});

      if (response.statusCode == 200 && response.data['success'] == true) {
        return User(username: username);
      } else {
        throw AppException('Login failed: ${response.data}');
      }
    } on DioException catch (e) {
      throw AppException('Network error: ${e.message}', e.stackTrace);
    } catch (e, stack) {
      throw AppException('Unexpected error: $e', stack);
    }
  }
}
