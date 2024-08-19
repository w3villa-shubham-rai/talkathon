import 'package:talkathon/features/groupmessage/data/datasource/group_remote_data_source.dart';
import 'package:talkathon/features/groupmessage/domain/gropu_entites.dart';
import 'package:talkathon/features/groupmessage/domain/repository/grouprepostory.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource remoteDataSource;

  GroupRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createGroup(Group group) {
    return remoteDataSource.createGroup(group);
  }

  @override
  Future<List<Group>> fetchGroups() async {
    return await remoteDataSource.fetchGroups(); // Implement fetching here
  }
}
