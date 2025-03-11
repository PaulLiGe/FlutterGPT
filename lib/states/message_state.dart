import 'package:chatgpt/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/injection.dart';

class MessageList extends StateNotifier<List<Message>> {
  MessageList() : super([]) {
    init();
  }

  Future<void> init() async {
    state = await db.messageDao.findAllMessages();
  }

  void addMessage(Message message) {
    state = [...state, message];
  }

  void upsertMessage(Message message) {
    final index = state.indexWhere((e) => e.id == message.id);
    var handledMessage = message;
    if (index >= 0) {
      handledMessage = handledMessage.copyWith(
          content: state[index].content + handledMessage.content);
    }
    db.messageDao.upsertMessage(handledMessage);
    if (index == -1) {
      state = [...state, handledMessage];
    } else {
      state = [...state]..[index] = handledMessage;
    }
  }
}

final messageProvider =
    StateNotifierProvider<MessageList, List<Message>>((ref) => MessageList());
