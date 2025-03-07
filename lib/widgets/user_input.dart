import 'package:chatgpt/states/chat_ui_state.dart';
import 'package:chatgpt/states/message_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../models/message.dart';
import 'package:logger/logger.dart';
import 'package:chatgpt/services/injection.dart';

class UserInputWidget extends HookConsumerWidget {
  const UserInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    return TextField(
      decoration: InputDecoration(
        hintText: "请输入",
        enabled: true,
        prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.message)),
        suffixIcon: IconButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _sendMessage(controller.text, ref, controller);
              }
            },
            icon: Icon(Icons.send)),
      ),
      controller: controller,
    );
  }

  void _sendMessage(
      String content, WidgetRef ref, TextEditingController controller) {
    final Message message = Message(
        content: content,
        isUserSend: true,
        sendTime: DateTime.now(),
        id: uuid.v4());
    controller.clear();
    ref.read(messageProvider.notifier).addMessage(message);
    _requestChatGPT(ref, content);
  }

  Future _requestChatGPT(WidgetRef ref, String content) async {
    ref.read(chatUIProvider.notifier).setRequestLoading(true);
    try {
      String id = uuid.v4();
      await chatgpt.streamChat(
        content,
        success: (text) {
          final message = Message(
              content: text,
              isUserSend: false,
              sendTime: DateTime.now(),
              id: id);
          ref.read(messageProvider.notifier).upsertMessage(message);
        },
      );
    } catch (error) {
      logger.e(error);
    } finally {
      ref.read(chatUIProvider.notifier).setRequestLoading(false);
    }
  }
}
