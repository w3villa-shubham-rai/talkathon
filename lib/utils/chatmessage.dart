import 'package:cloud_firestore/cloud_firestore.dart';

class CustomMessage {
  final String message;
  final String senderId;
  final Timestamp timestamp;

  CustomMessage({
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  factory CustomMessage.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomMessage(
      message: data['message'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
