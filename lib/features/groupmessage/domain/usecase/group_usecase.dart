
import 'package:talkathon/features/groupmessage/domain/gropu_entites.dart';
import 'package:talkathon/features/groupmessage/domain/repository/grouprepostory.dart';

class CreateGroupUseCase {
  final GroupRepository repository;

  CreateGroupUseCase(this.repository);

  Future<void> execute(String groupName, List<String> participantIds, String adminId) async {
    final group = Group(
      id: DateTime.now().toIso8601String(), 
      name: groupName,
      participantIds: participantIds, adminId: adminId, createdAt: DateTime.now(),
    );
    await repository.createGroup(group);
  }
}