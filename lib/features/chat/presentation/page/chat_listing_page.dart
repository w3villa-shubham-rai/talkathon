import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/core/theme/app_pallet.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_event.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_state.dart';
import 'package:talkathon/features/chatroom/presentation/pages/chat_room_page.dart';
import 'package:talkathon/features/message_for_group/presentation/pages/group_chatroom_message.dart';
import 'package:talkathon/features/groupmessage/presentation/group_creation_view.dart';
import 'package:talkathon/utils/component/custom_snackbar.dart';
import 'package:talkathon/utils/loaderframe.dart';


class ChatListingPage extends StatefulWidget {
  const ChatListingPage({super.key});

  @override
  State<ChatListingPage> createState() => _ChatListingPageState();
}

class _ChatListingPageState extends State<ChatListingPage> {
  late ChatBloc chatBloc;
  String? currentUserId;
  TextEditingController textSearchingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(UserListingEvent());
    chatBloc.add(FetchGroupsEvent());
    _getCurrentUserId();
  }

  void _getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUserId = user?.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatErrorState) {
              showSnackBar(context, "Error in ChatListingPage page");
            }
          },
          builder: (context, state) {
            if (state is ChatLoadingState) {
              return const Center(child: LoaderFrame());
            } else if (state is ChatSuccessState) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 33),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFF2F2F2)),
                            ),
                            child: TextFormField(
                              maxLines: 1,
                              controller: textSearchingController,
                              onChanged: (value) {
                                context.read<ChatBloc>().add(
                                  UserContactListingSearchingEvent(userTypingText: value),
                                );
                              },
                              decoration: const InputDecoration(
                                isDense: true,
                                fillColor: Color(0xffFFFFFF),
                                hintText: "Search User name",
                                hintStyle: TextStyle(color: Color(0xFFB7B7B7)),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Total Contacts- ${state.users?.length ?? '0'}",
                            style: const TextStyle(
                              color: Color(0xFFB7B7B7),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  // User Contacts List
                 
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final user = state.users![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserChatRoom(
                                  recevierId: user.uUid.toString(),
                                  currentUserId: currentUserId.toString(),
                                  userName: user.firstName.toString(),
                                  userProfileImage: user.imageUrl.toString(),
                                  isOnline: user.isOnline,
                                  lastSeen: user.lastOnline.toString(),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 33),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        user.imageUrl ?? "",
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.network(
                                            'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${user.firstName} ${user.lastName}',
                                        style: const TextStyle(
                                          color: Color(0xFF363636),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.users?.length ?? 0,
                    ),
                  ),
                  // Group List
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 33, right: 33),
                      child: Divider(color: Color(0xFFE0E0E0)),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final group = state.groups![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupChatRoom(
                                  groupId: group.id,
                                  groupName: group.name,
                                  participantIds: group.participantIds,
                                  adminId: group.adminId,
                                  currentUserId: currentUserId.toString(),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 33),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    child: const Icon(
                                      Icons.group,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    group.name ?? 'Unnamed Group',
                                    style: const TextStyle(
                                      color: Color(0xFF363636),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.groups?.length ?? 0,
                    ),
                  ),
                ],
              );
            } else if (state is ChatErrorState) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
      floatingActionButton: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: AppColors.cobaltBlue,
            onPressed: () {
              if (state is ChatSuccessState) {
                final users = state.users ?? [];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupCreationPage(users: users),
                  ),
                );
              } else {
                showSnackBar(context, "Failed to load users.");
              }
            },
            child: const Icon(Icons.chat, color: AppColors.antiFlashWhite),
          );
        },
      ),
    );
  }
}
