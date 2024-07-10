import 'package:talkathon/features/chatroom/data/models/message_model.dart';

class ChatRoomState {}

class ChatRoomIntialState extends ChatRoomState {}

class ChatRoomLaodingState extends ChatRoomState {}

class ChatRoomErrorState extends ChatRoomState {
  String? errorMessage;
  ChatRoomErrorState(this.errorMessage);
}

class ChatRoomSuceessState extends ChatRoomState{
  final List<Message> messages;
  ChatRoomSuceessState({this.messages = const []});
}
