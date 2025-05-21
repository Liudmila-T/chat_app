import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/observe_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../controllers/chat/chat_controller.dart';
import '../controllers/chat/chat_state.dart';
import 'login_providers.dart';

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  return ChatRemoteDataSourceImpl();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDataSource = ref.read(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource: remoteDataSource);
});

final sendMessageUseCaseProvider = Provider<SendMessageUseCase>((ref) {
  final repository = ref.read(chatRepositoryProvider);
  return SendMessageUseCase(repository);
});

final observeMessagesUseCaseProvider = Provider<ObserveMessagesUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ObserveMessagesUseCase(repository);
});

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  final sendMessageUseCase = ref.watch(sendMessageUseCaseProvider);
  final observeMessagesUseCase = ref.watch(observeMessagesUseCaseProvider);
  final username = ref.watch(currentUsernameProvider);
  return ChatController(sendMessageUseCase, observeMessagesUseCase, username);
});

final currentUsernameProvider = Provider<String>((ref) {
  final loginState = ref.watch(loginControllerProvider);
  return loginState.username;
});
