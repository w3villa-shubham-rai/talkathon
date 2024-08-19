import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chat/data/models/userlist_model.dart';
import 'package:talkathon/features/chat/domain/usecase/fetch_userGroup.dart';
import 'package:talkathon/features/chat/domain/usecase/userlisting_usecase.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_event.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_state.dart';
import 'package:talkathon/features/groupmessage/domain/gropu_entites.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UserListingUseCase userListingUseCase;
  final GroupListingUseCase groupListingUseCase;

  List<UserModel> allUsers = [];
  List<Group> allGroups = [];

  ChatBloc(this.userListingUseCase, this.groupListingUseCase)
      : super(ChatInitialState()) {
    on<FetchGroupsEvent>(_fetchUsersAndGroups);
    on<UserListingEvent>(_fetchUserList); // This is the critical part
    on<UserContactListingSearchingEvent>(_searchUserList);
  }

  Future<void> _fetchUserList(
      UserListingEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      final result = await userListingUseCase.call();
      if (result != null && result.isSuccess) {
        final List<UserModel> users = result.data as List<UserModel>;
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;

        allUsers = users.where((user) => user.uUid != currentUserId).toList();
        emit(ChatSuccessState(users: allUsers, groups: allGroups));
      } else {
        emit(ChatErrorState(errorMessage: result?.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(ChatErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _fetchUsersAndGroups(
      FetchGroupsEvent event, Emitter<ChatState> emit) async {
    debugPrint("fetchUsersAndGroups____________");
    emit(ChatLoadingState());
    try {
      await _fetchUserList(UserListingEvent(), emit);
      final groupResult = await groupListingUseCase.call();
      if (groupResult != null && groupResult.isSuccess) {
        allGroups = groupResult.data as List<Group>;
        for (var group in allGroups) {
          debugPrint("Group Name: ${group.name}");
        }

        emit(ChatSuccessState(users: allUsers, groups: allGroups));
      } else {
        emit(ChatErrorState(
            errorMessage:
                groupResult?.message ?? 'Unknown error while fetching groups'));
      }
    } catch (e) {
      emit(ChatErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _searchUserList(
      UserContactListingSearchingEvent event, Emitter<ChatState> emit) async {
    final query = event.userTypingText?.toLowerCase() ?? '';
    if (query.isEmpty) {
      emit(ChatSuccessState(users: allUsers, groups: allGroups));
    } else {
      final filteredUsers = allUsers.where((user) {
        final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
        return fullName.contains(query);
      }).toList();
      emit(ChatSuccessState(users: filteredUsers, groups: allGroups));
    }
  }
}
