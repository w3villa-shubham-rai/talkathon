import 'package:flutter/widgets.dart';
import 'package:talkathon/core/usecase/usecase.dart';
import 'package:talkathon/features/chat/data/models/userlist_model.dart';
import 'package:talkathon/features/chat/domain/repository/listing_user_base_repo.dart';
import 'package:talkathon/utils/success_type.dart';

class UserListingUseCase extends UseCase<SuccessType, Params> {
  FetchUsserListRepoBase fetchUsserListRepoBase;
  UserListingUseCase(this.fetchUsserListRepoBase);
  @override
  Future<SuccessType?> call({Params? params}) async {
    debugPrint("user data here ++");
    try {
      final result = await fetchUsserListRepoBase.fetchUserList();
      if (result!.isSuccess) {
        final List<UserModel> users = (result.data as List<UserModel>);
        return SuccessType(
          isSuccess: true,
          data: users,
          statusCode: 200,
          message: 'User list fetched successfully',
        );
      } else {
        return SuccessType(
          isSuccess: false,
          statusCode: 500,
          message: result.message.toString() ?? 'Unknown error',
        );
      }
    } catch (e) {
      debugPrint('Error in UserListingUseCase: $e');
      return SuccessType(
        isSuccess: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }
}

class Params {}
