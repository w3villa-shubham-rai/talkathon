class AuthSignUpStateBloc {}

class AuthSignUpIntialState extends AuthSignUpStateBloc {}

class AuthSignUpLoadingState extends AuthSignUpStateBloc {}

class AuthSignUpSucessState extends AuthSignUpStateBloc {
  String data;
  AuthSignUpSucessState(this.data);
}

class AuthSignupErrorState extends AuthSignUpStateBloc {
  final String errormessage;
  AuthSignupErrorState({required this.errormessage});
}
