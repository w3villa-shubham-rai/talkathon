import 'package:flutter/material.dart';
import 'package:talkathon/features/chat/domain/dataSourcebase/listing_user_datasource.dart';
import 'package:talkathon/features/chat/domain/repository/listing_user_base_repo.dart';
import 'package:talkathon/utils/success_type.dart';

class FetchUsserListRepoImpl implements FetchUsserListRepoBase {
  UserListFirebaseDataSourceBase userListFirebaseDataSourceBase;
  FetchUsserListRepoImpl(this.userListFirebaseDataSourceBase);
  @override
  Future<SuccessType?> fetchUserList() async {
    try {
      final userModels = await userListFirebaseDataSourceBase.fetchUserListFromServer();
      debugPrint("Fetched user models: $userModels");
      return SuccessType(
        isSuccess: true,
        data: userModels,
        statusCode: 200,
        message: 'User list fetched successfully',
      );
    } catch (e) {
      debugPrint("Error in fetchUserListFromServer: $e");
      return SuccessType(
        isSuccess: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
    // return userModels;
  }
}
