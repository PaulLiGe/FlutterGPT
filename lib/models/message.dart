import 'package:chatgpt/services/injection.dart';
import 'package:floor/floor.dart';

@entity
class Message {
  final String content;
  final bool isUserSend;
  final DateTime sendTime;
  @primaryKey
  final String id;

  Message(
      {required this.content,
      required this.isUserSend,
      required this.sendTime,
      required this.id});

  Map<String, dynamic> toJson() => {
        'content': content,
        'isUserSend': isUserSend,
        'sendTime': sendTime,
        'id': id,
      };
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        content: json['content'],
        isUserSend: json['isUserSend'],
        id: json['id'],
        sendTime: json['sendTime']);
  }

  // Message copyWith(
  //     {String? content, bool? isUserSend, DateTime? sendTime, String? id}) {
  //   return Message(
  //       content: content ?? this.content,
  //       isUserSend: isUserSend ?? this.isUserSend,
  //       sendTime: sendTime ?? this.sendTime,
  //       id: id ?? this.id);
  // }
}

extension MessageExtension on Message {
  Message copyWith(
      {String? id, String? content, bool? isUserSend, DateTime? sendTime}) {
    return Message(
        content: id ?? this.id,
        isUserSend: isUserSend ?? this.isUserSend,
        sendTime: sendTime ?? this.sendTime,
        id: id ?? this.id);
  }
}
