import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chat/data/models/userlist_model.dart';
import 'package:talkathon/features/chat/domain/usecase/userlisting_usecase.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_event.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  UserListingUseCase userListingUseCase;
  List<UserModel> allUsers = [];
  ChatBloc(this.userListingUseCase) : super(ChatInitialState()) {
    on<UserListingEvent>(_fetchUserList);
    on<UserContactListingSearchingEvent>(_searchUserList);
  }

 Future<void> _fetchUserList(UserListingEvent event, Emitter<ChatState> emit) async {
  emit(ChatLoadingState());
  try {
    final result = await userListingUseCase.call();
    if (result != null && result.isSuccess) {
      final List<UserModel> users = result.data as List<UserModel>;
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;

      final filteredUsers = users.where((user) => user.uUid != currentUserId).toList();
      emit(ChatSuccessState(users: filteredUsers));
    } else {
      emit(ChatErrorState(errorMessage: result?.message ?? 'Unknown error'));
    }
  } catch (e) {
    emit(ChatErrorState(errorMessage: e.toString()));
  }
}


  Future<void> _searchUserList(UserContactListingSearchingEvent event, Emitter<ChatState> emit)async{
    final query = event.userTypingText?.toLowerCase() ?? '';
    if (query.isEmpty) {
      emit(ChatSuccessState(users: allUsers));
    } else {
      final filteredUsers = allUsers.where((user) {
        final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
        return fullName.contains(query);
      }).toList();
      emit(ChatSuccessState(users: filteredUsers));
    }
  }
}
