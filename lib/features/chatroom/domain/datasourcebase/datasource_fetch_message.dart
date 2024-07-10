import 'package:talkathon/utils/success_type.dart';

abstract interface class FetchChatRoomMessageDataSourceRepo{
  Future<SuccessType?> getChatRoomMessage(String chatRoomId);
}
