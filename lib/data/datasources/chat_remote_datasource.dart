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

            return Message.fromJson(json);
          } catch (e) {
            return Message(text: 'Invalid message', sender: 'system', timestamp: DateTime.now(), isMine: false);
          }
        });
  }

  @override
  void sendMessage(Message message) {
    final jsonMessage = jsonEncode(message.toJson());
    _channel?.sink.add(jsonMessage);
  }

  @override
  void disconnect() {
    _channel?.sink.close();
  }
}
