class ChatEvent {}

class UserListingEvent extends ChatEvent {}

class UserContactListingSearchingEvent extends ChatEvent {
  String? userTypingText = '';
  UserContactListingSearchingEvent({this.userTypingText});
}




class FetchGroupsEvent extends ChatEvent {}

class CreateGroupEvent extends ChatEvent {
  final String groupName;
  final List<String> participantIds;
  final String adminId; 

  CreateGroupEvent({
    required this.groupName,
    required this.participantIds,
    required this.adminId,
  });
}
