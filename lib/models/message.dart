class Message {
  final String content;
  final bool isUserSend;
  final DateTime sendTime;

  Message(
      {required this.content,
      required this.isUserSend,
      required this.sendTime});

  Map<String, dynamic> toJson() => {
        'content': content,
        'isUserSend': isUserSend,
        'sendTime': sendTime,
      };
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        content: json['content'],
        isUserSend: json['isUserSend'],
        sendTime: json['sendTime']);
  }
}
