import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:talkathon/features/authsystem/domain/data_source/login_remote_data_source_base.dart';
import 'package:talkathon/features/authsystem/domain/entity/usersignin.dart';
import 'package:talkathon/utils/success_type.dart';

class UserSignInDataSourceImpl implements LoginDataSourceBase{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<SuccessType?> userSignIn(UserSignInEntity? params) async{
   try{
     UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword(email: params!.userEmail.toString(), password: params.userPassword.toString());
     debugPrint("user login Success here $userCredential");
     return SuccessType(isSuccess: true, message: "Signed in successfully");
   } on FirebaseAuthException catch(e)
    {
      return SuccessType(isSuccess: false, message: e.message);
    }
   catch(e)
    {
      return SuccessType(isSuccess: false, message: "An unexpected error occurred in Login");
    }
  }

}