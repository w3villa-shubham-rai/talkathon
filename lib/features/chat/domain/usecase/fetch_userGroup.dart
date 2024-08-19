import 'package:flutter/widgets.dart';
import 'package:talkathon/core/usecase/usecase.dart';
import 'package:talkathon/features/groupmessage/domain/repository/grouprepostory.dart';
import 'package:talkathon/utils/success_type.dart';

class GroupListingUseCase extends UseCase<SuccessType, Params> {
  final GroupRepository groupRepository;

  GroupListingUseCase(this.groupRepository);

  @override
  Future<SuccessType?> call({Params? params}) async {
    debugPrint("Fetching group data here ++");
    try {
      final groups = await groupRepository.fetchGroups();
      return SuccessType(
        isSuccess: true,
        data: groups,
        statusCode: 200,
        message: 'Group list fetched successfully',
      );
    } catch (e) {
      debugPrint('Error in GroupListingUseCase: $e');
      return SuccessType(
        isSuccess: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }
}

class Params {}
