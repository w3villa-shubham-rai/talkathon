import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talkathon/features/authsystem/presentation/page/SignupPage.dart';
import 'package:talkathon/features/authsystem/presentation/page/loginPage.dart';
import 'package:talkathon/features/chat/presentation/page/chat_listing_page.dart';


class AuthWrapper extends StatelessWidget {
  final FirebaseAuth firebaseAuth;

  const AuthWrapper({super.key, required this.firebaseAuth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (firebaseAuth.currentUser != null) {
          Future.microtask(() {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ChatListingPage(),
            ));
          });
          return const SizedBox.shrink(); // Return an empty widget while navigation happens
        }

        if (snapshot.hasData) {
          return const LoginPage();
        } else {
          return const SignUpPage();
        }
      },
    );
  }
}
