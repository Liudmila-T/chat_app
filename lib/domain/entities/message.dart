class Message {
  final String text;
  final String sender;
  final DateTime timestamp;
  final bool isMine;

  Message({required this.text, required this.sender, required this.timestamp, required this.isMine});
}
