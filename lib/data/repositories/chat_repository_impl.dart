import 'dart:async';

import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Message> getMessagesStream() {
    return remoteDataSource.messages.map((rawMessage) {
      return Message(text: rawMessage, sender: 'other', timestamp: DateTime.now(), isMine: false);
    });
  }

  @override
  Future<void> sendMessage(Message message) async {
    remoteDataSource.sendMessage(message.text);
  }

  @override
  Future<void> connect() async {
    remoteDataSource.connect();
  }

  @override
  Future<void> disconnect() async {
    remoteDataSource.disconnect();
  }
}
