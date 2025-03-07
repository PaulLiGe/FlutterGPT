import 'package:chatgpt/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageList extends StateNotifier<List<Message>> {
  MessageList() : super([]);

  void addMessage(Message message) {
    state = [...state, message];
  }

  void upsertMessage(Message message) {
    final index = state.indexWhere((e) => e.id == message.id);
    if (index == -1) {
      state = [...state, message];
    } else {
      List<Message> newList = List.from(state);
      final oldMessage = newList[index];
      newList[index] =
          message.copyWith(content: oldMessage.content + message.content);
      state = newList;
      print("重新build拉,是upsert了");
    }
  }
}

final messageProvider =
    StateNotifierProvider<MessageList, List<Message>>((ref) => MessageList());
