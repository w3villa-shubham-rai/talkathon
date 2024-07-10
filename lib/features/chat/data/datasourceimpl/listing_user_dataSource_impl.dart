import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:talkathon/features/chat/data/models/userlist_model.dart';
import 'package:talkathon/features/chat/domain/dataSourcebase/listing_user_datasource.dart';

class ListingUserDataSourceImpl extends UserListFirebaseDataSourceBase {
  final FirebaseFirestore firebaseFireStore;

  ListingUserDataSourceImpl(this.firebaseFireStore);

  @override
  Future<List<UserModel>> fetchUserListFromServer() async {
    try {
      debugPrint("Fetching user list...");
      final querySnapshot = await firebaseFireStore.collection('users').get();
      debugPrint("Fetching user list... data: ${querySnapshot.docs}");

      final List<UserModel> users = querySnapshot.docs.map((doc) {
        // debugPrint("abcdefgh  $doc.data()");
        // Map<dynamic, dynamic> value=doc.data();
        // {
        //   country:"India"
        //   firstName:"shubham"
        // }
        // debugPrint("ddddddddddd  $value");
        return UserModel.fromSnapshot(doc.data());

      }).toList();

      debugPrint("Users fetched: $users");
      return users;
    } catch (e) {
      debugPrint("Error in fetchUserListFromServer: $e");
      return [];
    }
  }
}
