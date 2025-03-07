import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/services/injection.dart';
import 'package:chatgpt/states/chat_ui_state.dart';
import 'package:chatgpt/widgets/chat_message_list.dart';
import 'package:flutter/material.dart';
import 'message_item.dart';
import '../states/message_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer';
import 'package:logger/logger.dart';
import './user_input.dart';

class ChatScreen extends HookConsumerWidget {
  ChatScreen({super.key});

  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageProvider);
    print('重新build拉');
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Expanded(
              child: ChatMessageList(),
            ),
            UserInputWidget(),
          ],
        ),
      ),
    );
  }
}
