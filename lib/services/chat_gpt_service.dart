import 'package:openai_api/openai_api.dart';
import 'package:chatgpt/services/chat_gpt_service.dart';

class ChatGPTService {
  static String key = "sk-xwTlOZ1pwoWXjdgU4KrP3APIh3sNuB9RnC1jXrRYhsWGp0ht";
  final client = OpenaiClient(
      config:
          OpenaiConfig(apiKey: key, baseUrl: "https://api.chatanywhere.tech"));

  Future<ChatCompletionResponse> sendChat(String content) async {
    final request = ChatCompletionRequest(model: "gpt-3.5-turbo", messages: [
      ChatMessage(
        content: content,
        role: ChatMessageRole.user,
      ),
    ]);
    return await client.sendChatCompletion(request);
  }
}
