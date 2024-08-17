import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chatroom/domain/usecase/chatroom_usecase.dart';
import 'package:talkathon/features/chatroom/domain/usecase/fetch_message_usecase.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chat_room_event.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chatroom_state.dart';

class ChatRoombloc extends Bloc<UserChatRoomEvent, ChatRoomState> {
  final ChatRoomUserCase chatRoomUseCase;
  final FetchMessageUseCase fetchMessageUseCase;
  
  ChatRoombloc(this.chatRoomUseCase, this.fetchMessageUseCase)
      : super(ChatRoomIntialState()) {
    on<UserSendMessageEvent>(createMesssageChannel);
    on<FetchMessagesEvent>(showMessages);
  }

  Future<void> createMesssageChannel(
      UserSendMessageEvent event, Emitter<ChatRoomState> emit) async {
    emit(ChatRoomLaodingState());
    try {
      final result = await chatRoomUseCase.call(
          params: Params( message: event.message,  senderId: event.senderId,reciverId: event.recevierId));
      debugPrint("result of messsage +++ $result");
      if (result != null && result.isSuccess) {
        // emit(ChatRoomSuceessState());
      } else {
        emit(ChatRoomErrorState(result?.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(ChatRoomErrorState(e.toString()));
    }
  }

  Future<void> showMessages(
      FetchMessagesEvent event, Emitter<ChatRoomState> emit) async {
    try {
      final result = await fetchMessageUseCase.call(params: FetchMessageParams(reciverId: event.recevierId, senderId: event.senderId));
      debugPrint("call showMessages ${result!.data.toString()}");
      if (result != null && result.isSuccess) {
        emit(ChatRoomSuceessState(messages: result.data));
      } else {
        emit(ChatRoomErrorState(result?.message ?? 'Unknown error'));
      }
    } catch (e) {
       debugPrint("call showMessages $e");
      emit(ChatRoomErrorState(e.toString()));
    }
  }
}
