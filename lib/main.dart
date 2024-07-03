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
import 'package:talkathon/features/authsystem/presentation/page/SignupPage.dart';
import 'package:talkathon/utils/auth_wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final authremoteInterfaceCallImpl = AuthRemoteInterfaceCallImpl(firebaseAuth);
    final authRepository = AuthRepositoryImpl(authremoteInterfaceCallImpl); 
    final userSignUpUseCase = UserSignUpUseCase(authRepository);
    final userSignInRemoteCall=UserSignInDataSourceImpl();
    final signUpUserRepoImpl= AuthSignInImpl(userSignInRemoteCall);
    final userLoginUseCase=UserSignInUseCase(signUpUserRepoImpl);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthSignupBloc(userSignUpUseCase: userSignUpUseCase,userSignInUseCase: userLoginUseCase),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthWrapper(firebaseAuth: firebaseAuth),
        // BlocProvider(
        //     create: (context) => AuthSignupBloc(userSignUpUseCase: userSignUpUseCase),
        //     child: const SignUpPage()),
      ),
    );
  }
}
