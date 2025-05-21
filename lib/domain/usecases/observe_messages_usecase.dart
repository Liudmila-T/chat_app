import 'package:chat_app/domain/entities/message.dart';
import 'package:chat_app/domain/repositories/chat_repository.dart';

class ObserveMessagesUseCase {
  final ChatRepository _repository;

  ObserveMessagesUseCase(this._repository);

  Stream<Message> call() {
    return _repository.observeMessages();
  }

  Future<void> connect() => _repository.connect();

  Future<void> disconnect() => _repository.disconnect();
}
