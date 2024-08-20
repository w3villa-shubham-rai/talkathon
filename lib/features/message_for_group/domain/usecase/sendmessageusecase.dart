

import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';
import 'package:talkathon/features/message_for_group/domain/repository/group_message_repository.dart';

class SendMessageUseCase {
  final GroupMessageRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> execute(String groupId, GroupMessage message) {
    return repository.sendMessage(groupId, message);
  }
}

