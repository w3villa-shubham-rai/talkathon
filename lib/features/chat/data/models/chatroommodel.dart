import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final String name;
  final List<String> memberIds;
  final Timestamp createdAt;
  String? recentMessage;
  int unreadMessageCount;

  ChatRoom({
    required this.id,
    required this.name,
    required this.memberIds,
    required this.createdAt,
    this.recentMessage,
    this.unreadMessageCount = 0,
  });

  factory ChatRoom.fromFireStore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      name: data['name'] ?? '',
      memberIds: List<String>.from(data['memberIds'] ?? []),
      createdAt: data['createdAt'] ?? Timestamp.now(),
      recentMessage: data['recentMessage'],
      unreadMessageCount: data['unreadMessageCount'] ?? 0,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'memberIds': memberIds,
      'createdAt': createdAt,
      'recentMessage': recentMessage,
      'unreadMessageCount': unreadMessageCount,
    };
  }
}
