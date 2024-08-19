

import 'package:talkathon/features/groupmessage/domain/gropu_entites.dart';

abstract class GroupRepository {
  Future<void> createGroup(Group group);
  Future<List<Group>> fetchGroups();
}
