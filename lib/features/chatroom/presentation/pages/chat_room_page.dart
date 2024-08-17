import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talkathon/core/theme/app_pallet.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chat_room_bloc.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chat_room_event.dart';
import 'package:talkathon/utils/padding_marging.dart';

class UserChatRoom extends StatefulWidget {
  final String recevierId;
  final String currentUserId;
  final String userName;
  final String userProfileImage;

  const UserChatRoom({
    super.key,
    required this.recevierId,
    required this.currentUserId,
    required this.userName,
    required this.userProfileImage,
  });

  @override
  State<UserChatRoom> createState() => _UserChatRoomState();
}

class _UserChatRoomState extends State<UserChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
    chatRoomId = _generateChatRoomId();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getallMessages(
      String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chatRooms/$chatRoomId/messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  late String chatRoomId;
  void fetchMessages() {
    try {
      context.read<ChatRoombloc>().add(FetchMessagesEvent(
            senderId: widget.currentUserId,
            recevierId: widget.recevierId,
          ));
    } catch (e) {
      debugPrint("Error fetchMessages function messages: $e')");
    }
  }

  String _generateChatRoomId() {
    List<String> ids = [widget.currentUserId, widget.recevierId];
    ids.sort();
    return ids.join('_');
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFF8F8F8),
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getallMessages(chatRoomId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            if (data != null) {
              for (var doc in data) {
                debugPrint("MESSAGE OF DATA: ${doc.data()}");
              }
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
            return ListView.builder(
              controller: _scrollController,
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                final reversedIndex = data!.length - index - 1;
                final message = data?[reversedIndex];
                final isCurrentUser =
                    message?['senderId'] == widget.currentUserId;
                final timestamp = message?['timestamp'];
                String timeString = '';
                if (timestamp != null) {
                  timeString = DateFormat('hh:mm a').format(timestamp.toDate());
                }
                return Align(
                    alignment: isCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: isCurrentUser
                                ? Color(0xFFE8EEFC)
                                : Color(0xFFEDEDED),
                          ),
                          child: Text(
                            message?['message'] ?? '',
                            style: const TextStyle(
                                color: AppColors.blackColor, fontSize: 15),
                          ).paddingSymmetric(horizontal: 10, vertical: 8),
                        ),
                        Text(
                          timeString,
                          style: const TextStyle(
                              color: Color(0xFF646464), fontSize: 9),
                        ).paddingSymmetric(horizontal: 10, vertical: 3),
                      ],
                    )

                    // Container(
                    //   margin:
                    //       const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     color:
                    //         isCurrentUser ? Colors.blue[200] : Colors.grey[300],
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: isCurrentUser
                    //         ? CrossAxisAlignment.end
                    //         : CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         message?['message'] ?? '',
                    //         style: TextStyle(
                    //           color: isCurrentUser ? Colors.white : Colors.black,
                    //         ),
                    //       ),
                    //       const SizedBox(height: 5),
                    //       Text(
                    //         timeString,
                    //         style: TextStyle(
                    //           color:
                    //               isCurrentUser ? Colors.white70 : Colors.black54,
                    //           fontSize: 10,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    );
              },
            );
          } else {
            return const Center(child: Text('No messages yet.'));
          }
        },
      ).paddingSymmetric(horizontal: 5),
      bottomNavigationBar: SafeArea(child: _buildMessageInput()),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(11)),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: AppColors.antiFlashWhite,
              spreadRadius: 1,
            )
          ]),
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
                hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
    ).paddingSymmetric(horizontal: 10);
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
