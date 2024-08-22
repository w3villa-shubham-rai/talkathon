import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';

abstract class GroupMessageEvent {}

class SendMessageEvent extends GroupMessageEvent {
  final String groupId;
  final GroupMessage message;

  SendMessageEvent(this.groupId, this.message);
}

class LoadMessagesEvent extends GroupMessageEvent {
  final String groupId;
  final String adminId;

  LoadMessagesEvent(this.groupId, this.adminId);
}
