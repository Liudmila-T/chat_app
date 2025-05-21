import 'dart:async';

import 'package:either_dart/either.dart';

import '../../core/failures/app_failure.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Message> observeMessages() => remoteDataSource.getMessages();

  @override
  @override
  Future<Either<Failure, void>> sendMessage(Message message) async {
    try {
      remoteDataSource.sendMessage(message);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to send message: $e'));
    }
  }

  @override
  Future<void> connect() async => remoteDataSource.connect();

  @override
  Future<void> disconnect() async => remoteDataSource.disconnect();
}
