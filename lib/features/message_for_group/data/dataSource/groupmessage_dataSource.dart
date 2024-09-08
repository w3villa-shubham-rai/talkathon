import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';

class GroupMessageRemoteDataSource {
  final FirebaseFirestore firestore;

  GroupMessageRemoteDataSource(this.firestore);

  Future<void> sendMessage(String groupId, GroupMessage message) async {
    await firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<GroupMessage>> getMessages(String groupId) {
    debugPrint("getMessages function 3____________");
    return firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('sentAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GroupMessage.fromMap(doc.data()))
            .toList());
  }

  
}
