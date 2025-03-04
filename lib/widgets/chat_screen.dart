import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/services/injection.dart';
import 'package:flutter/material.dart';
import 'message_item.dart';
import '../states/message_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatScreen extends HookConsumerWidget {
  ChatScreen({super.key});

  // final List<Message> messages = [
  //   Message(content: "hello", isUserSend: true, sendTime: DateTime.now()),
  //   Message(
  //       content: "How are you?", isUserSend: false, sendTime: DateTime.now()),
  //   Message(
  //       content: "Fine, Thank you, and you",
  //       isUserSend: true,
  //       sendTime: DateTime.now()),
  //   Message(content: "I am fine.", isUserSend: false, sendTime: DateTime.now()),
  // ];

  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, idx) {
                  return MessageItem(message: messages[idx]);
                },
                separatorBuilder: (context, idx) {
                  return Divider(
                    height: 16,
                    color: Colors.red,
                  );
                },
                itemCount: messages.length,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "请输入",
                prefixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.message)),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (_textFieldController.text.isNotEmpty) {
                        _sendMessage(_textFieldController.text, ref);
                      }
                    },
                    icon: Icon(Icons.send)),
              ),
              controller: _textFieldController,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String content, WidgetRef ref) {
    final Message message =
        Message(content: content, isUserSend: true, sendTime: DateTime.now());
    _textFieldController.clear();
    ref.read(messageProvider.notifier).addMessage(message);
    _requestChatGPT(ref, content);
  }

  Future _requestChatGPT(WidgetRef ref, String content) async {
    final res = await chatgpt.sendChat(content);
    final text = res.choices.first.message?.content ?? "";
    print('沃日你姐$text');
    final message =
        Message(content: text, isUserSend: false, sendTime: DateTime.now());
    ref.read(messageProvider.notifier).addMessage(message);
  }
}
