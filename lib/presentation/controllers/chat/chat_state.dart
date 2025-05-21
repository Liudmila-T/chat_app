import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({@Default([]) List<Message> messages, @Default(false) bool isSending, String? errorMessage}) =
      _ChatState;
}
