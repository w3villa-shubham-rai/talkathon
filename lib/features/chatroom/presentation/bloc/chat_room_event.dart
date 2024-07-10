class UserChatRoomEvent {}

class UserSendMessageEvent extends UserChatRoomEvent {
  final String message;
  final String senderId;
  final String recevierId;
  UserSendMessageEvent({required this.message, required this.senderId, required this.recevierId});
}

class FetchMessagesEvent extends UserChatRoomEvent {
  final String senderId;
  final String recevierId;

FetchMessagesEvent({required this.senderId, required this.recevierId});

  @override
  List<Object?> get props => [senderId, recevierId];
}