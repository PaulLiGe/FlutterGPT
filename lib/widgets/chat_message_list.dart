import 'package:chatgpt/states/message_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openai_api/openai_api.dart';
import './message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatMessageList extends HookConsumerWidget {
  const ChatMessageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageProvider);
    final scrollController = useScrollController();
    ref.listen(messageProvider, (pre, next) {
      Future.delayed(Duration(milliseconds: 50), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
    return ListView.separated(
      itemBuilder: (context, idx) {
        return MessageMarkdownItem(message: messages[idx]);
      },
      controller: scrollController,
      separatorBuilder: (context, idx) {
        return Divider(
          height: 16,
          color: Colors.red,
        );
      },
      itemCount: messages.length,
    );
  }
}
