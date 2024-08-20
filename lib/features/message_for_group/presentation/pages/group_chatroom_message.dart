// lib/features/groupmessage/presentation/pages/group_chat_room.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  const GroupChatRoom({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.participantIds,
    required this.adminId,
  }) : super(key: key);

  @override
  _GroupChatRoomState createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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
      debugPrint( "her edat i want to show ${widget.adminId},${DateTime.now().millisecondsSinceEpoch.toString()}");
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: BlocConsumer<GroupMessageBloc, GroupMessageState>(
        listener: (context, state) {
          if (state is GroupMessageFailure) {
            showSnackBar(context, state.errorMessage);
          } else if (state is GroupMessageSuccess) {
            // Optionally handle success (e.g., show a confirmation message)
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount:
                      10, // This should be dynamically populated from the state
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('User $index: Message $index'),
                    );
                  },
                ),
              ),
              SafeArea(
                child: buildMessageInput(),
              ),
            ],
          );
        },
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
}
