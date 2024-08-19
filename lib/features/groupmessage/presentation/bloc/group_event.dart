abstract class GroupCreationEvent {}

class CreateGroupEvent extends GroupCreationEvent {
  final String groupName;
  final List<String> participantIds;
  final String adminId;

  CreateGroupEvent(this.groupName, this.participantIds, this.adminId);
}
