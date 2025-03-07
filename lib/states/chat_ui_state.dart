import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatUIState {
  final bool requestLoading;

  ChatUIState({this.requestLoading = false});
}

class ChatUIStateProvider extends StateNotifier<ChatUIState> {
  ChatUIStateProvider() : super(ChatUIState());

  void setRequestLoading(bool requestLoading) {
    state = ChatUIState(requestLoading: requestLoading);
  }
}

final chatUIProvider = StateNotifierProvider<ChatUIStateProvider, ChatUIState>(
    (res) => ChatUIStateProvider());
