// login_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_provider.dart';
import '../../data/datasources/login_remote_datasource.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../domain/repositories/login_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_controller.dart';
import 'login_state.dart';

final loginRemoteDataSourceProvider = Provider<LoginRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return LoginRemoteDatasourceImpl(dio);
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final remoteDataSource = ref.watch(loginRemoteDataSourceProvider);
  return LoginRepositoryImpl(remoteDataSource);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(loginRepositoryProvider);
  return LoginUseCase(repository);
});

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  final useCase = ref.watch(loginUseCaseProvider);
  return LoginController(useCase);
});
