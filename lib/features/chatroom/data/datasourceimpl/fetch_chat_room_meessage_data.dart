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
      QuerySnapshot snapshot = await fireStore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();
      debugPrint("chat room data here ${snapshot.docs}");
      List<Message> messages = snapshot.docs.map((doc) {
        return Message.fromFireStore(doc);
      }).toList();
      debugPrint("message in main last ___${messages.length}");
      return SuccessType(isSuccess: true, data: messages);
    } catch (error) {
      return SuccessType(message: error.toString(), isSuccess: false);
    }
  }

//  Stream<QuerySnapshot<Map<String, dynamic>>> getallMessages(String chatRoomId) {
//     return fireStore.collection('chatRooms/${chatRoomId}/messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }
 
}


  




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:talkathon/features/chatroom/data/models/message_model.dart';
// import 'package:talkathon/features/chatroom/domain/datasourcebase/datasource_fetch_message.dart';
// import 'package:talkathon/utils/success_type.dart';

// class FetchMessageDataSourceImpl implements FetchChatRoomMessageDataSourceRepo {
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;

//   @override
//   Future<SuccessType?> getChatRoomMessage(String chatRoomId) async {
//     try {
//       Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = fireStore.collection('chatRooms/$chatRoomId/messages').orderBy('timestamp', descending: true).snapshots();
//       //  debugPrint("chat room data here ${snapshot.data.}");
//       snapshot.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
//   // Iterate over the documents in the snapshot
//   for (var document in snapshot.docs) {
//     // Print the document data
//     debugPrint("Document data: ${document.data()}");
//   }
// });
//       // List<Message> messages = snapshot.docs.map((doc) {
//       //   // debugPrint("chat room data here ${doc.data()}");
//       //   return Message.fromFireStore(doc);
//       // }).toList();
//       // debugPrint("message in main last ___${messages.length}");
//       // return SuccessType(isSuccess: true, data: messages);
//     } catch (error) {
//       return SuccessType(message: error.toString(), isSuccess: false);
//     }
//   }
// }

