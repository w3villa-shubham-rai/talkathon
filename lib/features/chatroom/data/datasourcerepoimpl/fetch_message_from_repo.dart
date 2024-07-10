import 'package:flutter/material.dart';
import 'package:talkathon/features/chatroom/domain/repository/fetch_chat_room_message.dart';
import 'package:talkathon/features/chatroom/domain/datasourcebase/datasource_fetch_message.dart';
import 'package:talkathon/utils/success_type.dart';

class FetchMessageRepoImpl implements FetchChatRoomMessagebaseRepo {
  final FetchChatRoomMessageDataSourceRepo dataSource;

  FetchMessageRepoImpl(this.dataSource);

  @override
  Future<SuccessType?> fetchChatRoomMessage(String chatRoomId)async {
    debugPrint("id here $chatRoomId");
    return await dataSource.getChatRoomMessage(chatRoomId);
  }
}
