import 'package:flutter/material.dart';
import 'package:talkathon/features/chatroom/domain/repository/fetch_chat_room_message.dart';
import 'package:talkathon/utils/success_type.dart';
import 'package:talkathon/core/usecase/usecase.dart';

class FetchMessageUseCase extends UseCase<SuccessType, FetchMessageParams> {
  final FetchChatRoomMessagebaseRepo fetchChatRoomMessagebaseRepo;

  FetchMessageUseCase(this.fetchChatRoomMessagebaseRepo);

  @override
  Future<SuccessType?> call({FetchMessageParams? params}) async {
    debugPrint("ChatRoomUserCase call ++++");
  if (params == null) {
      return SuccessType(isSuccess: false, message: "Params cannot be null");
    }
    List<String> ids = [params.senderId, params.reciverId];
    ids.sort();
    final String chatRoomId = ids.join('_');
    return await fetchChatRoomMessagebaseRepo.fetchChatRoomMessage(chatRoomId);
  }
}

class FetchMessageParams {
  final String senderId;
  final String reciverId;

  FetchMessageParams({required this.senderId, required this.reciverId});
}
