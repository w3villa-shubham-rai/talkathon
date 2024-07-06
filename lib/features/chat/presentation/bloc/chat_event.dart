class ChatEvent {
  
}
class UserListingEvent extends ChatEvent {
}

class UserContactListingSearchingEvent extends ChatEvent{
  String? userTypingText='';
  UserContactListingSearchingEvent({this.userTypingText});
}