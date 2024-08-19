import 'package:talkathon/features/chat/data/models/userlist_model.dart';
import 'package:talkathon/features/groupmessage/domain/gropu_entites.dart';

class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  String? errorMessage;
  ChatErrorState({this.errorMessage});
}

class ChatSuccessState extends ChatState {
  final List<UserModel>? users;
  final String? userInputText;
  final List<Group> groups;
  ChatSuccessState({required this.users, this.userInputText,required this.groups,});
}
