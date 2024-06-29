class AuthEvent{

}

class AuthSignUpEvent extends AuthEvent{
  final String uUid;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String country;
  final String imgUrl;
  final String phoneNumber;
  AuthSignUpEvent({required this.uUid, required this.firstName,required this.lastName,required this.email,required this.password,required this.country,required this.imgUrl,required this.phoneNumber});
}
