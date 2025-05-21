import 'dart:convert';

import 'package:chat_app/core/constants/app_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/entities/message.dart';

abstract class ChatRemoteDataSource {
  Stream<Message> getMessages();
  void sendMessage(Message message);
  void connect();
  void disconnect();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  WebSocketChannel? _channel;

  @override
  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(AppConstants.wsUrl));
  }

  @override
  Stream<Message> getMessages() {
    return _channel!.stream
        .where((data) {
          final isJson = data.trim().startsWith('{');
          return isJson;
        })
        .map((data) {
          try {
            final json = jsonDecode(data);

            return Message(
              text: json['text'] as String,
              sender: json['sender'] as String,
              timestamp: DateTime.parse(json['timestamp'] as String),
              isMine: false,
            );
          } catch (e) {
            return Message(text: 'Invalid message', sender: 'system', timestamp: DateTime.now(), isMine: false);
          }
        });
  }

  @override
  void sendMessage(Message message) {
    final jsonMessage = jsonEncode({
      'text': message.text,
      'sender': message.sender,
      'timestamp': message.timestamp.toIso8601String(),
    });
    _channel?.sink.add(jsonMessage);
  }

  @override
  void disconnect() {
    _channel?.sink.close();
  }
}
