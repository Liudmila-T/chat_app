import 'package:web_socket_channel/web_socket_channel.dart';

abstract class ChatRemoteDataSource {
  Stream<String> get messages;
  void sendMessage(String message);
  void connect();
  void disconnect();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  WebSocketChannel? _channel;

  @override
  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));
  }

  @override
  void sendMessage(String message) {
    _channel?.sink.add(message);
  }

  @override
  Stream<String> get messages => _channel!.stream.map((event) => event.toString());

  @override
  void disconnect() {
    _channel?.sink.close();
  }
}
