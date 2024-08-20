
import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';
import 'package:talkathon/features/message_for_group/data/dataSource/groupmessage_dataSource.dart';
import 'package:talkathon/features/message_for_group/domain/repository/group_message_repository.dart';

class GroupMessageRepositoryImpl implements GroupMessageRepository {
  final GroupMessageRemoteDataSource remoteDataSource;

  GroupMessageRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sendMessage(String groupId, GroupMessage message) {
    return remoteDataSource.sendMessage(groupId, message);
  }

  @override
  Stream<List<GroupMessage>> getMessages(String groupId) {
    return remoteDataSource.getMessages(groupId);
  }
}
