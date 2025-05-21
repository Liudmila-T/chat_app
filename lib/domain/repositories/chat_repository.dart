import '../entities/message.dart';

abstract class ChatRepository {
  Stream<Message> getMessagesStream();
  Future<void> sendMessage(Message message);
  Future<void> connect();
  Future<void> disconnect();
}
