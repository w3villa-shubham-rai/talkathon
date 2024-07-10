import 'package:talkathon/features/chatroom/domain/datasourcebase/chat_room_data_source.dart';
import 'package:talkathon/features/chatroom/domain/repository/chatroom_base_repo.dart';
import 'package:talkathon/features/chatroom/domain/usecase/chatroom_usecase.dart';
import 'package:talkathon/utils/success_type.dart';

class ChatRoomRepoImpl implements ChatRoomRepobase {
  ChatRoomDataSourcebase chatRoomDataSourcebase;
  ChatRoomRepoImpl(this.chatRoomDataSourcebase);
  @override
  Future<SuccessType?> chatRoomCreate(Params? params) async {
    return chatRoomDataSourcebase.chatRoomCreateOnServer(params!);
  }
}
