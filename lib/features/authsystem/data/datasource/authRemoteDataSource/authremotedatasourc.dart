import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:talkathon/features/authsystem/domain/data_source/auth_remote_data_source_base.dart';
import 'package:talkathon/features/authsystem/domain/entity/signupuserentity.dart';
import 'package:talkathon/utils/success_type.dart';

class AuthRemoteInterfaceCallImpl implements AuthremoteInterfaceCall {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteInterfaceCallImpl(this._firebaseAuth);

  @override
  Future<SuccessType?> signUpDataSource(UserSignUpEntity params) async {
    UserCredential? userCredential;

    try {
       debugPrint("params data here  data source ${params!.firstName},${params!.lastName},${params!.country},${params!.imageUrl},${params!.password},${params!.userEmail},${params!.phoneNumber}");
       userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.userEmail.toString(),
        password: params.password.toString(),
      );
      debugPrint("User created with result: $userCredential");
       if (userCredential.user != null){
        String uid = userCredential.user!.uid;
        String? imageUrl;

         try {
           if (params.imageUrl != null) {
            File imageFile = File(params.imageUrl!);
             if (!imageFile.existsSync()) {
            debugPrint("File does not exist at path: ${params.imageUrl}");
            return SuccessType(isSuccess: false, message: "Image file does not exist");
          }

           try {
            UploadTask uploadTask = FirebaseStorage.instance.ref().child('user_profile/$uid').putFile(imageFile);
            TaskSnapshot snapshot = await uploadTask;
            imageUrl = await snapshot.ref.getDownloadURL();
            debugPrint("Image uploaded successfully: $imageUrl");
           } catch (error) {
              debugPrint("Error uploading image: $error");
            return SuccessType(isSuccess: false, message: "Image upload failed");
           }
          }
          try {
            await FirebaseFirestore.instance.collection("users").doc(uid).set(
              params.copyWith(uUid: uid, imageUrl: imageUrl).toJson(),
            );
            debugPrint("User data saved to Firestore successfully.");
            return SuccessType(isSuccess: true, message: "New User Created");
          } catch (error) {
            debugPrint("Error saving user data to Firestore: $error");
            return SuccessType(isSuccess: false, message: "Error saving user data");
          }
         } catch (error) {
            debugPrint("Error uploading image: $error");
          return SuccessType(isSuccess: false, message: "Image upload failed");
         }

       }
       else {
        return SuccessType(isSuccess: false, message: "User creation failed");
      }
    }  
    on FirebaseAuthException catch (error) {
      debugPrint("FirebaseAuthException: $error");
      return SuccessType(message: error.message.toString(), isSuccess: false);
    } catch (error) {
      debugPrint("Unexpected error: $error");
      return SuccessType(message: error.toString(), isSuccess: false);
    }

  
  }
}

