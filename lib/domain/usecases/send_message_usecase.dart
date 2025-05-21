import 'package:either_dart/either.dart';

import '../../core/failures/app_failure.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failure, void>> call(Message message) {
    return repository.sendMessage(message);
  }
}
