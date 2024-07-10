import 'package:talkathon/features/chat/data/models/userlist_model.dart';

abstract class UserListFirebaseDataSourceBase {
  Future<List<UserModel>> fetchUserListFromServer();
}
