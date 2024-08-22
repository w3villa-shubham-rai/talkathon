import 'package:flutter/material.dart';
import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';
import 'package:talkathon/features/message_for_group/domain/repository/group_message_repository.dart';

class GetMessagesUseCase {
  final GroupMessageRepository repository;

  GetMessagesUseCase(this.repository);

  Stream<List<GroupMessage>> execute(String groupId) {
    debugPrint("getMessages function ${groupId}____________");
    return repository.getMessages(groupId);
  }
}
