import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../data/datasources/login_remote_datasource.dart';
import '../../../data/repositories/login_repository_impl.dart';
import '../../../domain/repositories/login_repository.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../controllers/login/login_controller.dart';
import '../controllers/login/login_state.dart';

final _loginRemoteDataSourceProvider = Provider<LoginRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return LoginRemoteDatasourceImpl(dio);
});

final _loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final remoteDataSource = ref.watch(_loginRemoteDataSourceProvider);
  return LoginRepositoryImpl(remoteDataSource);
});

final _loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(_loginRepositoryProvider);
  return LoginUseCase(repository);
});

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  final useCase = ref.watch(_loginUseCaseProvider);
  return LoginController(useCase);
});
