import 'package:flutter/material.dart';
import 'package:talkathon/core/usecase/usecase.dart';
import 'package:talkathon/features/chatroom/data/datasourcerepoimpl/chatroom_base_room_impl.dart';
import 'package:talkathon/features/chatroom/domain/repository/chatroom_base_repo.dart';
import 'package:talkathon/utils/success_type.dart';

class ChatRoomUserCase extends UseCase<SuccessType, Params> {
  final ChatRoomRepoImpl chatRoomRepoImpl;
  ChatRoomUserCase(this.chatRoomRepoImpl);
  @override
  Future<SuccessType?> call({Params? params}) {
  
    return chatRoomRepoImpl.chatRoomCreate(params);
  }
}

class Params {
  final String message;
  final String senderId;
  final String reciverId;

  Params(
      {required this.message, required this.senderId, required this.reciverId});
}
