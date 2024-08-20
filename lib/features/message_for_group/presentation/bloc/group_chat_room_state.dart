import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';

abstract class GroupMessageState {}

class GroupMessageInitial extends GroupMessageState {}

class GroupMessageInProgress extends GroupMessageState {}

class GroupMessageSuccess extends GroupMessageState {}

class GroupMessageFailure extends GroupMessageState {
  final String errorMessage;

  GroupMessageFailure(this.errorMessage);
}

class GroupMessageLoaded extends GroupMessageState {
  final List<GroupMessage> messages;

  GroupMessageLoaded({required this.messages});
}
