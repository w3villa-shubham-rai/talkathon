abstract class GroupCreationState {}

class GroupCreationInitial extends GroupCreationState {}

class GroupCreationInProgress extends GroupCreationState {}

class GroupCreationSuccess extends GroupCreationState {}

class GroupCreationFailure extends GroupCreationState {
  final String errorMessage;

  GroupCreationFailure(this.errorMessage);
}
