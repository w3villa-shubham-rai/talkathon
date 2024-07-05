import 'package:talkathon/features/chat/data/models/userlist_model.dart';

class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  String? errorMessage;
  ChatErrorState({this.errorMessage});
}

class ChatSuccessState extends ChatState {
  final List<UserModel> users;
  ChatSuccessState({required this.users});
}
