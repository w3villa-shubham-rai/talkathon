import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/message_for_group/domain/usecase/get_messages_usecase.dart';
import 'package:talkathon/features/message_for_group/domain/usecase/sendmessageusecase.dart';
import 'package:talkathon/features/message_for_group/presentation/bloc/group_chat_room_event.dart';
import 'package:talkathon/features/message_for_group/presentation/bloc/group_chat_room_state.dart';

class GroupMessageBloc extends Bloc<GroupMessageEvent, GroupMessageState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;

  GroupMessageBloc({
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
  }) : super(GroupMessageInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<LoadMessagesEvent>(_onLoadMessages);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<GroupMessageState> emit) async {
    emit(GroupMessageInProgress());
    try {
      await sendMessageUseCase.execute(event.groupId, event.message);
      debugPrint("group id ${event.groupId}");
      emit(GroupMessageSuccess());
    } catch (e) {
      emit(GroupMessageFailure(e.toString()));
    }
  }

  void _onLoadMessages(
      LoadMessagesEvent event, Emitter<GroupMessageState> emit) {
    emit(GroupMessageInProgress());
    try {
      event.messages.listen((messages) {
        emit(GroupMessageLoaded(messages: messages));
      });
    } catch (e) {
      emit(GroupMessageFailure(e.toString()));
    }
  }
}
