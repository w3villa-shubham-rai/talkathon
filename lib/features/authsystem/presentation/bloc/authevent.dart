class AuthEvent{

}

class AuthSignUpEvent extends AuthEvent{
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String country;
  final String imgUrl;
  AuthSignUpEvent({required this.firstName,required this.lastName,required this.email,required this.password,required this.country,required this.imgUrl});
}
