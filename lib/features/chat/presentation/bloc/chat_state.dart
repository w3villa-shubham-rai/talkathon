class ChatState{

}

class ChatInitialState extends ChatState{

}
class ChatLoadingState extends ChatState{
}
class ChatErrorState extends ChatState{
  String? errorMessage;
  ChatErrorState({this.errorMessage});
}

class ChatSuccessState extends ChatState{

}