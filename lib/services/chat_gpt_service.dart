// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:openai_api/openai_api.dart';
import 'package:chatgpt/services/chat_gpt_service.dart';

class ChatGPTService {
  static String key = "sk-oIF7CMJWTFVivnBO5aFcF761A93e4c8b93906a85170dFe0e";
  final client = OpenaiClient(
      config: OpenaiConfig(apiKey: key, baseUrl: "https://free.v36.cm"));

  Future<ChatCompletionResponse> sendChat(String content) async {
    final request = ChatCompletionRequest(model: "gpt-3.5-turbo", messages: [
      ChatMessage(
        content: content,
        role: ChatMessageRole.user,
      ),
    ]);
    return await client.sendChatCompletion(request);
  }

  Future streamChat(String content, {Function(String text)? success}) async {
    final request =
        ChatCompletionRequest(model: "gpt-3.5-turbo", stream: true, messages: [
      ChatMessage(
        content: content,
        role: ChatMessageRole.user,
      ),
    ]);

    return await client.sendChatCompletionStream(request, onSuccess: (p0) {
      final text = p0.choices.first.delta?.content;
      print(p0.choices.first.delta.toString());
      if (text != null) {
        success?.call(text);
        print("回调stream$text");
      }
    });
  }
}
