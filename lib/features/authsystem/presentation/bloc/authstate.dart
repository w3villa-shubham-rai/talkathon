class AuthSignUpStateBloc {}

class AuthSignUpIntialState extends AuthSignUpStateBloc {}

class AuthSignUpLoadingState extends AuthSignUpStateBloc {}

class AuthSignUpSucessState extends AuthSignUpStateBloc {
  final String? data;
  final String? imagePath;
  AuthSignUpSucessState({this.data,this.imagePath});
}

class AuthSignupErrorState extends AuthSignUpStateBloc {
  final String errorMessage;
  AuthSignupErrorState({required this.errorMessage});
}


