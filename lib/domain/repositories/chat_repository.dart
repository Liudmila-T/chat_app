import 'package:either_dart/either.dart';

import '../../core/failures/app_failure.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Stream<Message> observeMessages();
  Future<Either<Failure, void>> sendMessage(Message message);
  Future<void> connect();
  Future<void> disconnect();
}
