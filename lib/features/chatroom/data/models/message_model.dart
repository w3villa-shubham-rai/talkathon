import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final String message;
  final String senderId;
  final DateTime timestamp;

  Message({
    required this.messageId,
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  factory Message.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      messageId: doc.id,
      message: data['message'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
