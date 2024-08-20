

import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';

abstract class GroupMessageRepository {
  Future<void> sendMessage(String groupId, GroupMessage message);
  Stream<List<GroupMessage>> getMessages(String groupId);
}
