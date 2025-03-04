import 'package:chatgpt/models/message.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: message.isUserSend ? Colors.blue : Colors.black,
          foregroundColor: message.isUserSend ? Colors.black : Colors.white,
          child: Text(message.isUserSend ? "Me" : "GPT"),
        ),
        SizedBox(
          width: 8,
        ),
        Text(message.content),
      ],
    );
  }
}
