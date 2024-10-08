import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/authsystem/data/datasource/authRemoteDataSource/authremotedatasourc.dart';
import 'package:talkathon/features/authsystem/data/datasource/authRemoteDataSource/user_signIn_data_source_impl.dart';
import 'package:talkathon/features/authsystem/data/repositories/userSignupReposityImpl.dart';
import 'package:talkathon/features/authsystem/data/repositories/usersigninRepositryImpl.dart';
import 'package:talkathon/features/authsystem/domain/usecase/SignupUsecase.dart';
import 'package:talkathon/features/authsystem/domain/usecase/login_usecase.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authbloc.dart';
import 'package:talkathon/features/authsystem/presentation/page/loginPage.dart';
import 'package:talkathon/features/chat/data/datasourceimpl/listing_user_dataSource_impl.dart';
import 'package:talkathon/features/chat/data/repositoryimpl/listing_user_repo_impl.dart';
import 'package:talkathon/features/chat/domain/usecase/fetch_userGroup.dart';
import 'package:talkathon/features/chat/domain/usecase/userlisting_usecase.dart';
import 'package:talkathon/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:talkathon/features/chat/presentation/page/chat_listing_page.dart';
import 'package:talkathon/features/chatroom/data/datasourceimpl/chat_room_datasource.dart';
import 'package:talkathon/features/chatroom/data/datasourceimpl/fetch_chat_room_meessage_data.dart';
import 'package:talkathon/features/chatroom/data/datasourcerepoimpl/chatroom_base_room_impl.dart';
import 'package:talkathon/features/chatroom/data/datasourcerepoimpl/fetch_message_from_repo.dart';
import 'package:talkathon/features/chatroom/domain/usecase/chatroom_usecase.dart';
import 'package:talkathon/features/chatroom/domain/usecase/fetch_message_usecase.dart';
import 'package:talkathon/features/chatroom/presentation/bloc/chat_room_bloc.dart';
import 'package:talkathon/features/groupmessage/data/datasource/group_remote_data_source.dart';
import 'package:talkathon/features/groupmessage/data/repository/group_repository_impl.dart';
import 'package:talkathon/features/groupmessage/domain/usecase/group_usecase.dart';
import 'package:talkathon/features/groupmessage/presentation/bloc/group_bloc.dart';
import 'package:talkathon/features/message_for_group/data/dataSource/groupmessage_dataSource.dart';
import 'package:talkathon/features/message_for_group/data/repository/GroupMessageRepositoryImpl.dart';
import 'package:talkathon/features/message_for_group/domain/usecase/get_messages_usecase.dart';
import 'package:talkathon/features/message_for_group/domain/usecase/sendmessageusecase.dart';
import 'package:talkathon/features/message_for_group/presentation/bloc/group_chat_room_bloc.dart';
import 'package:talkathon/utils/status_off_online.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final userStatusManager = UserStatusManager();
  WidgetsBinding.instance.addObserver(userStatusManager);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget  with WidgetsBindingObserver {
  const MyApp({super.key});


//  In the didChangeAppLifecycleState method,
//   check if the app is in the resumed state (indicating the app is in the foreground)
//   or paused state (indicating the app is in the background) and update the user status accordingly.

// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if(state== AppLifecycleState.resumed)
//     {
       
//     }
//     else if(state==AppLifecycleState.paused){

//     }

//   }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // Dependency injection
    final authremoteInterfaceCallImpl =
        AuthRemoteInterfaceCallImpl(firebaseAuth);
    final authRepository = AuthRepositoryImpl(authremoteInterfaceCallImpl);
    final userSignUpUseCase = UserSignUpUseCase(authRepository);
    final userSignInRemoteCall = UserSignInDataSourceImpl();
    final signUpUserRepoImpl = AuthSignInImpl(userSignInRemoteCall);
    final userLoginUseCase = UserSignInUseCase(signUpUserRepoImpl);

    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    final userListFirebaseDataSource =
        ListingUserDataSourceImpl(firebaseFireStore);
    final fetchUsserListRepo =
        FetchUsserListRepoImpl(userListFirebaseDataSource);
    final userListingUseCase = UserListingUseCase(fetchUsserListRepo);
    final chatRoomDataSourceImpl = ChatRoomDataSourceImpl(firebaseFireStore);
    final chatRoomRepoImpl = ChatRoomRepoImpl(chatRoomDataSourceImpl);
    final chatRoomUserCase = ChatRoomUserCase(chatRoomRepoImpl);
    final fetchMessageDataSourceImpl = FetchMessageDataSourceImpl();
    final fetchMessageRepoImpl =
        FetchMessageRepoImpl(fetchMessageDataSourceImpl);
    final fetchMessageUseCase = FetchMessageUseCase(fetchMessageRepoImpl);

    // ++++++++++++++++Group listing page+++++++++++
    final firebaseFirestore = FirebaseFirestore.instance;
    final groupRemoteDataSource = GroupRemoteDataSource(firebaseFirestore);
    final groupRepository = GroupRepositoryImpl(groupRemoteDataSource);
    final groupListingUseCase = GroupListingUseCase(groupRepository);

// +++++++++++++++++++  send grop message ++++++++++++++++

final groupMessageRemoteDataSource = GroupMessageRemoteDataSource(firebaseFirestore);

// Create an instance of the concrete repository
final groupMessageRepository = GroupMessageRepositoryImpl(groupMessageRemoteDataSource);

 
  final getMessagesUseCase = GetMessagesUseCase(groupMessageRepository);
  final sendMessageUseCase = SendMessageUseCase(groupMessageRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthSignupBloc(
            userSignUpUseCase: userSignUpUseCase,
            userSignInUseCase: userLoginUseCase,
          ),
        ),
        BlocProvider(
          create: (context) =>
              ChatRoombloc(chatRoomUserCase, fetchMessageUseCase),
        ),
        BlocProvider(
          create: (context) =>
              ChatBloc(userListingUseCase, groupListingUseCase),
        ),
        BlocProvider(
          create: (context) => GroupCreationBloc(
            CreateGroupUseCase(
              GroupRepositoryImpl(
                GroupRemoteDataSource(FirebaseFirestore.instance),
              ),
            ),
          ),
        ),
        BlocProvider<GroupMessageBloc>(
          create: (context) => GroupMessageBloc(
            sendMessageUseCase: sendMessageUseCase,
            getMessagesUseCase: getMessagesUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: checkauth(firebaseAuth),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return snapshot.data == true
                  ? const ChatListingPage()
                  : const LoginPage();
            }
          },
        ),
      ),
    );
  }

  Future<bool> checkauth(FirebaseAuth firebaseAuth) async {
    User? user = firebaseAuth.currentUser;
    if (firebaseAuth.currentUser == null) {
      return false;
    } else {
      try {
        await user!.reload();
        user = firebaseAuth.currentUser;
        if (user == null || user.uid.isEmpty) {
          firebaseAuth.signOut();
          return false;
        }
      } catch (e) {
        if (e is FirebaseAuthException && e.code == 'user-not-found') {
          firebaseAuth.signOut();
          return false;
        } else {
          print('Error during user verification: $e');
          firebaseAuth.signOut();
          return false;
        }
      }
      return true;
    }
  }
}
