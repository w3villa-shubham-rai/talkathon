import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/chat/data/models/userlist_model.dart';
import 'package:talkathon/features/groupmessage/presentation/bloc/group_bloc.dart';
import 'package:talkathon/features/groupmessage/presentation/bloc/group_event.dart';
import 'package:talkathon/features/groupmessage/presentation/bloc/group_state.dart';
import 'package:talkathon/utils/component/custom_snackbar.dart';

import '../../chat/domain/entity/userlisting_entity.dart';

class GroupCreationPage extends StatefulWidget {
  final List<UserModel> users;

  GroupCreationPage({required this.users});

  @override
  _GroupCreationPageState createState() => _GroupCreationPageState();
}

class _GroupCreationPageState extends State<GroupCreationPage> {
  final TextEditingController groupNameController = TextEditingController();
  Set<String> selectedUserIds = {};

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  String getAdminId() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.uid ?? ''; 
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
    final adminId = getAdminId();
    if (groupName.isNotEmpty && selectedUserIds.isNotEmpty) {
      context.read<GroupCreationBloc>().add(
        CreateGroupEvent(groupName, selectedUserIds.toList(),adminId),
      );
    } else {
      showSnackBar(
          context, "Please enter a group name and select at least one user");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Group"),
      ),
      body: BlocConsumer<GroupCreationBloc, GroupCreationState>(
        listener: (context, state) {
          if (state is GroupCreationFailure) {
            showSnackBar(context, state.errorMessage);
          } else if (state is GroupCreationSuccess) {
            Navigator.pop(context); // Close the page on success
          }
        },
        builder: (context, state) {
          if (state is GroupCreationInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
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
                  itemCount: widget.users.length,
                  itemBuilder: (context, index) {
                    final user = widget.users[index];
                    final isSelected = selectedUserIds.contains(user.uUid);

                    return ListTile(
                      onTap: () => _onUserTap(user.uUid),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.imageUrl ??
                            'https://via.placeholder.com/150'),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.check_circle_outline),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createGroup,
        child: const Icon(Icons.check),
      ),
    );
  }
}
