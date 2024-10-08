import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talkathon/features/chat/domain/entity/userlisting_entity.dart';

class UserModel {
  final String uUid;
  final String country;
  final String firstName;
  final String? imageUrl;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String userEmail;
  final bool isOnline;
  final DateTime? lastOnline;

  UserModel({
    required this.uUid,
    required this.country,
    required this.firstName,
    required this.imageUrl,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.userEmail,
    this.isOnline=false,
    this.lastOnline,
  });

  factory UserModel.fromSnapshot(Map<dynamic, dynamic> value) {
    return UserModel(
      uUid: value['uUid'] as String,
      country: value['country'] as String,
      firstName: value['firstName'] as String,
      imageUrl: value['imageUrl'] as String??"",
      lastName: value['lastName'] as String,
      password: value['password'] as String,
      phoneNumber: value['phoneNumber'] as String,
      userEmail: value['userEmail'] as String,
      isOnline: value['isOnline'] as bool? ?? false,
     lastOnline: (value['lastOnline'] as Timestamp?)?.toDate(), 
    );
  }

  User toEntity() {
    return User(
      uUid: uUid,
      country: country,
      firstName: firstName,
      imageUrl: imageUrl??"",
      lastName: lastName,
      password: password,
      phoneNumber: phoneNumber,
      userEmail: userEmail,
      isOnline: isOnline,
      lastOnline: lastOnline?.toIso8601String() ?? "",
    );
  }
}
