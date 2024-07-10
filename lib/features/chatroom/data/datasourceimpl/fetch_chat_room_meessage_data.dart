import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talkathon/features/chatroom/data/models/message_model.dart';
import 'package:talkathon/features/chatroom/domain/datasourcebase/datasource_fetch_message.dart';
import 'package:talkathon/utils/success_type.dart';

class FetchMessageDataSourceImpl implements FetchChatRoomMessageDataSourceRepo {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Future<SuccessType?> getChatRoomMessage(String chatRoomId) async {
    try {
      QuerySnapshot snapshot = await fireStore.collection('chatRooms').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: true).get();
      List<Message> messages = snapshot.docs.map((doc) {
        return Message.fromFireStore(doc);
      }).toList();
      debugPrint("message in main last ___${messages.length}");
      return SuccessType(isSuccess: true, data: messages);
    } catch (error) {
      return SuccessType(message: error.toString(), isSuccess: false);
    }
  }
}
