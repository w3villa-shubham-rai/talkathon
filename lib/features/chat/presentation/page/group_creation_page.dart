import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chat/data/models/userlist_model.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_event.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_state.dart';
import 'package:talkathon/utils/component/custom_snackbar.dart';

class GroupCreationPage extends StatefulWidget {
  @override
  State<GroupCreationPage> createState() => _GroupCreationPageState();
}

class _GroupCreationPageState extends State<GroupCreationPage> {
  final TextEditingController groupNameController = TextEditingController();
  Set<String> selectedUserIds = {}; 
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(UserListingEvent()); 
  }

  void _onUserTap(String userId) {
    setState(() {
      if (selectedUserIds.contains(userId)) {
        selectedUserIds.remove(userId); 
      } else {
        selectedUserIds.add(userId); 
      }
    });
  }

  void _createGroup() {
    final groupName = groupNameController.text.trim();
    if (groupName.isNotEmpty && selectedUserIds.isNotEmpty) {
      // Call your BLoC or service to create a group with `groupName` and `selectedUserIds`
      print("Group Name: $groupName");
      print("Selected Users: $selectedUserIds");
    } else {
      showSnackBar(context, "Please enter a group name and select at least one user");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Group"),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatErrorState) {
            showSnackBar(context, "Failed to load users");
          }
        },
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatSuccessState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: groupNameController,
                    decoration: const InputDecoration(
                      labelText: "Group Name",
                      hintText: "Enter group name",
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.users?.length ?? 0,
                    itemBuilder: (context, index) {
                      final user = state.users![index];
                      final isSelected = selectedUserIds.contains(user.uUid);

                      return ListTile(
                        onTap: () => _onUserTap(user.uUid!),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.imageUrl ?? ''),
                        ),
                        title: Text('${user.firstName} ${user.lastName}' ?? 'No Name'),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No users found"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createGroup,
        child: const Icon(Icons.check),
      ),
    );
  }
}
