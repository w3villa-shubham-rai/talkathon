class UserSignInEntity{
  final String userEmail;
  final String userPassword;
  UserSignInEntity({required this.userEmail,required this.userPassword});

  factory UserSignInEntity.fromMap(Map<String,dynamic> map){
   return
     UserSignInEntity(
         userEmail: map['userEmail'] as String,
         userPassword: map['userPassword']as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }
}