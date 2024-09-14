import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserStatusManager with WidgetsBindingObserver {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final user = _firebaseAuth.currentUser;
    if (user != null) {
      switch (state) {
        case AppLifecycleState.resumed:
          _updateUserStatus(true);
          debugPrint("here call APi ++++11 for Status");
          break;
        case AppLifecycleState.paused:
         debugPrint("here call APi ++++22 for Status");
          _updateUserStatus(false);
          break;
        default:
          break;
      }
    }
  }

  Future<void> _updateUserStatus(bool isOnline) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'isOnline': isOnline,
        'lastOnline': DateTime.now(), 
      });
    }
  }
}
