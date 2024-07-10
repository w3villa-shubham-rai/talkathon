import 'package:talkathon/features/chatroom/domain/usecase/chatroom_usecase.dart';
import 'package:talkathon/utils/success_type.dart';

abstract interface class ChatRoomDataSourcebase {
  Future<SuccessType?> chatRoomCreateOnServer(Params params);
}
