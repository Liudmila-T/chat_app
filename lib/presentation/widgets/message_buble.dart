import 'package:flutter/material.dart';

import '../../../domain/entities/message.dart';
import '../../core/constants/app_colors.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;

    final bubbleColor = isMine ? AppColors.primary : Colors.grey[300];
    final textColor = isMine ? Colors.white : Colors.black;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(color: bubbleColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isMine)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  message.sender,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54),
                ),
              ),
            Text(message.text, style: TextStyle(color: textColor)),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _formatTimestamp(message.timestamp),
                style: TextStyle(fontSize: 10, color: isMine ? Colors.white70 : Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
