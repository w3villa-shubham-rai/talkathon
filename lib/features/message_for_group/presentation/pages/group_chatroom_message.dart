
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talkathon/core/theme/app_pallet.dart';
import 'package:talkathon/features/groupmessage/domain/entity/group_messag_entity.dart';
import 'package:talkathon/features/message_for_group/presentation/bloc/group_chat_room_bloc.dart';
import 'package:talkathon/features/message_for_group/presentation/bloc/group_chat_room_event.dart';
import 'package:talkathon/features/message_for_group/presentation/bloc/group_chat_room_state.dart';
import 'package:talkathon/utils/component/custom_snackbar.dart';
import 'package:talkathon/utils/padding_marging.dart';

class GroupChatRoom extends StatefulWidget {
  final String groupId;
  final String groupName;
  final List<String> participantIds;
  final String adminId;
  final String currentUserId;

  const GroupChatRoom({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.participantIds,
    required this.adminId,
    required this.currentUserId,
  });

  @override
  _GroupChatRoomState createState() => _GroupChatRoomState();
}

// 

class _GroupChatRoomState extends State<GroupChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController=ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context
        .read<GroupMessageBloc>()
        .add(LoadMessagesEvent(widget.groupId, widget.adminId));
  }

  void _sendMessage() {
    final messageContent = _messageController.text.trim();
    if (messageContent.isNotEmpty) {
      final message = GroupMessage(
        senderId: widget.adminId,
        text: messageContent,
        sentAt: DateTime.now(),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      debugPrint(
          "her edat i want to show ${widget.adminId},${DateTime.now().millisecondsSinceEpoch.toString()}");
      context.read<GroupMessageBloc>().add(
            SendMessageEvent(widget.groupId, message),
          );

      _messageController.clear();
    } else {
      showSnackBar(context, "Message cannot be empty");
    }
  }

@override
Widget build(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final keyboardHeight = mediaQuery.viewInsets.bottom;
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.groupName),
    ),
    body: Column(
      children: [
        BlocConsumer<GroupMessageBloc, GroupMessageState>(
          listener: (context, state) {
            if (state is GroupMessageFailure) {
              showSnackBar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is GroupMessageLoaded) {
              return StreamBuilder<List<GroupMessage>>(
                stream: state.messages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No messages yet.'));
                  } else {
                     WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });
                    return Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final message = snapshot.data![index];
                            final isCurrentUser = message.senderId == widget.currentUserId;
                            final timestamp = message.sentAt;
                            String timeString = '';
                            if (timestamp != null) {
                              timeString = DateFormat('hh:mm a').format(timestamp);
                            }
                                
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: isCurrentUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: isCurrentUser,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: Colors.amber,
                                    ),
                                  ).paddingSymmetric(horizontal: 8),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: isCurrentUser
                                            ? const Color(0xFFE8EEFC)
                                            : const Color(0xFFEDEDED),
                                      ),
                                      child: Text(
                                        message.text ?? '',
                                        style: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 15),
                                      ).paddingSymmetric(horizontal: 10, vertical: 8),
                                    ),
                                     Text(
                                     timeString,
                                      style: const TextStyle(
                                          color: Color(0xFF646464), fontSize: 9),
                                    ).paddingSymmetric(horizontal: 10, vertical: 3),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const Center(child: Text('Loading messages...'));
            }
          },
        ),
        buildMessageInput(),
      ],
    ),
    
  );
}

  Widget buildMessageInput() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(11)),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Color(0xFFE0E0E0),
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Start Message",
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 10),
    );
  }

   void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
