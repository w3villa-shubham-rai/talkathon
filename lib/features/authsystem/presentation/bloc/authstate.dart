class AuthSignUpStateBloc {}

class AuthSignUpIntialState extends AuthSignUpStateBloc {}

class AuthSignUpLoadingState extends AuthSignUpStateBloc {}

class AuthSignUpSucessState extends AuthSignUpStateBloc {
  final String? data;
  AuthSignUpSucessState({this.data});
}

// Add a new state for image selection success
class ImageSelectionSuccessState extends AuthSignUpStateBloc {
  final String imagePath;
  ImageSelectionSuccessState({required this.imagePath});
}


class AuthSignupErrorState extends AuthSignUpStateBloc {
  final String errorMessage;
  AuthSignupErrorState({required this.errorMessage});
}
