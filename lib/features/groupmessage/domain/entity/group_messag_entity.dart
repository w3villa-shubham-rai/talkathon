// domain/entity/group_message.dart

class GroupMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime sentAt;

  GroupMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.sentAt,
  });

  get timestamp => null;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text,
      'sentAt': sentAt.toIso8601String(),
    };
  }
  factory GroupMessage.fromMap(Map<String, dynamic> map) {
    return GroupMessage(
      id: map['id'] as String,
      senderId: map['senderId'] as String,
      text: map['text'] as String,
      sentAt: DateTime.parse(map['sentAt'] as String),
    );
  }
}
