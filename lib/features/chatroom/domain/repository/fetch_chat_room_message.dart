import 'package:talkathon/utils/success_type.dart';

abstract interface class FetchChatRoomMessagebaseRepo {
  Future<SuccessType?> fetchChatRoomMessage(String chatRoomId);
}
