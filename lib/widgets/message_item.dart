import 'package:chatgpt/markdown/latex.dart';
import 'package:chatgpt/models/message.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/config/all.dart';

class MessageMarkdownItem extends StatelessWidget {
  const MessageMarkdownItem({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: MarkdownGenerator(
          generators: [latexGenerator],
          inlineSyntaxList: [LatexSyntax()]).buildWidgets(message.content),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: message.isUserSend ? Colors.blue : Colors.black,
          foregroundColor: message.isUserSend ? Colors.black : Colors.white,
          child: Text(message.isUserSend ? "Me" : "GPT"),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(child: Text(message.content)),
      ],
    );
  }
}
