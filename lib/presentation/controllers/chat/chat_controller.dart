import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/usecases/observe_messages_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import 'chat_state.dart';

class ChatController extends StateNotifier<ChatState> {
  final SendMessageUseCase _sendMessageUseCase;
  final ObserveMessagesUseCase _observeMessagesUseCase;
  final String username;

  ChatController(this._sendMessageUseCase, this._observeMessagesUseCase, this.username) : super(const ChatState()) {
    _connect();
    _observeMessages();
  }
  void _connect() {
    _observeMessagesUseCase.connect();
  }

  void disconnect() {
    _observeMessagesUseCase.disconnect();
  }

  void _observeMessages() {
    _observeMessagesUseCase().listen((message) {
      state = state.copyWith(messages: [message, ...state.messages]);
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    state = state.copyWith(isSending: true, errorMessage: null);
    final newMessage = Message(text: text, sender: username, timestamp: DateTime.now(), isMine: true);

    state = state.copyWith(messages: [newMessage, ...state.messages], isSending: true, errorMessage: null);
    final result = await _sendMessageUseCase(newMessage.copyWith(isMine: false));
    result.fold((failure) => state = state.copyWith(errorMessage: failure.message), (_) {});

    state = state.copyWith(isSending: false);
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
