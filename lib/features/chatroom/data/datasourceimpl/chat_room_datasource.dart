import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talkathon/features/chatroom/domain/datasourcebase/chat_room_data_source.dart';
import 'package:talkathon/utils/success_type.dart';

class ChatRoomDataSourceImpl implements ChatRoomDataSourcebase {
  final FirebaseFirestore firestore;
  ChatRoomDataSourceImpl(this.firestore);
  @override
  Future<SuccessType?> chatRoomCreateOnServer(params) async {
    try {
      final String chatRoomId ='${params.senderId}_${params.reciverId}';
      final chatRoomRef = firestore.collection('chatRooms').doc(chatRoomId);
      debugPrint("chat room refernace $chatRoomRef");
      await chatRoomRef.set({
        'lastMessage': params.message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await chatRoomRef.collection('messages').add({
        'message': params.message,
        'senderId': params.senderId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return SuccessType(isSuccess: true, message: 'Message sent successfully');
    } catch (e) {
      return SuccessType(isSuccess: false, message: e.toString());
    }
  }
}