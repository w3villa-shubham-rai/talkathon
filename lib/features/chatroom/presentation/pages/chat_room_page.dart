import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chatroom/data/models/message_model.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chat_room_bloc.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chat_room_event.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chatroom_state.dart';
import 'package:talkathon/utils/component/custom_snackbar.dart';
import 'package:talkathon/utils/component/extension_of_size.dart';
import 'package:talkathon/utils/loaderframe.dart';
import 'package:talkathon/utils/padding_marging.dart';

class UserChatRoom extends StatefulWidget {
  final String recevierId;
  final String currentUserId;
  final String userName;
  final String userProfileImage;

  const UserChatRoom({
    Key? key,
    required this.recevierId,
    required this.currentUserId,
    required this.userName,
    required this.userProfileImage,
  }) : super(key: key);

  @override
  State<UserChatRoom> createState() => _UserChatRoomState();
}

class _UserChatRoomState extends State<UserChatRoom> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
    // Fetch initial messages
    context.read<ChatRoombloc>().add(FetchMessagesEvent(
          senderId: widget.currentUserId,
          recevierId: widget.recevierId,
        ));
  }
  void fetchMessages() {
  try {
    context.read<ChatRoombloc>().add(FetchMessagesEvent(
      senderId: widget.currentUserId,
      recevierId: widget.recevierId,
    ));
  } catch (e) {
    print('Error fetching messages: $e');
    
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            ClipOval(
              child: Image.network(
                widget.userProfileImage,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 40);
                },
              ),
            ),
            const SizedBox(width: 10),
            Text(widget.userName),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: BlocConsumer<ChatRoombloc, ChatRoomState>(
        listener: (context, state) {
          if (state is ChatRoomErrorState) {
            showSnackBar(context, "Error in ChatListingPage page");
          }
        },
        builder: (context, state) {
          if (state is ChatRoomLaodingState) {
            return const Center(child: LoaderFrame());
          } else if (state is ChatRoomSuceessState) {
            List<Message> messages = state.messages;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index].message;
                      return ListTile(
                        title: Text(messages[index].senderId),
                        subtitle: Text(message),
                      );
                    },
                  ),
                ),
                _buildMessageInput(),
                SizedBox(height: 10),
              ],
            ).paddingSymmetric(horizontal: 30, vertical: 30);
          } else if (state is ChatRoomErrorState) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            // Initial state or any other state handling
            return Column(
              children: [
                Expanded(child: Container()),
                _buildMessageInput(),
                SizedBox(height: 10),
              ],
            ).paddingSymmetric(horizontal: 30, vertical: 30);
          }
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(27)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextFormField(
              maxLines: null,
              controller: _messageController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Start Message",
                contentPadding: EdgeInsets.only(left: 10),
                hintStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ).paddingOnly(bottom: 4),
          ),
          Container(
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF40518A),
            ),
            child: InkWell(
              onTap: () {
                final message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  context.read<ChatRoombloc>().add(
                        UserSendMessageEvent(
                          message: message,
                          recevierId: widget.recevierId,
                          senderId: widget.currentUserId,
                        ),
                      );
                  _messageController.clear();
                }
              },
              child: const Icon(
                Icons.send,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ).paddingSymmetric(horizontal: 10, vertical: 10)
        ],
      ),
    );
  }
}
