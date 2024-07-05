import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chat/domain/usecase/userlisting_usecase.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_event.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  UserListingUseCase userListingUseCase;
  ChatBloc(this.userListingUseCase) : super(ChatInitialState()) {
    on<UserListingEvent>(_fetchUserList);
  }

  Future<void> _fetchUserList(
      UserListingEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    final result = await userListingUseCase.call();
    if (result != null && result.isSuccess) {
      emit(ChatSuccessState(users: result.data));
    } else {
      emit(ChatErrorState(errorMessage: result?.message));
    }
  }
}
