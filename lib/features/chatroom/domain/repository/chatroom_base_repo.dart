import 'package:talkathon/features/chatroom/domain/usecase/chatroom_usecase.dart';
import 'package:talkathon/utils/success_type.dart';

abstract interface class ChatRoomRepobase {
  Future<SuccessType?> chatRoomCreate(Params? params);
}
