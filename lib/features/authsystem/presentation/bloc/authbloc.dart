import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/authsystem/domain/entity/signupuserentity.dart';
import 'package:talkathon/features/authsystem/domain/entity/usersignin.dart';
import 'package:talkathon/features/authsystem/domain/usecase/SignupUsecase.dart';
import 'package:talkathon/features/authsystem/domain/usecase/login_usecase.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authevent.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authstate.dart';
import 'package:talkathon/utils/imagepicker.dart';

class AuthSignupBloc extends Bloc<AuthEvent, AuthSignUpStateBloc> {
  final UserSignUpUseCase userSignUpUseCase;
  final UserSignInUseCase userSignInUseCase;
  AuthSignupBloc({required this.userSignUpUseCase,required this.userSignInUseCase}) : super(AuthSignUpIntialState()) {
    on<AuthSignUpEvent>(_handleSignUp);
    on<ImagePickerEvent>(_handleImageSelected);
    on<AuthSignInEvent>(_handleSignIn);
  }

  Future<void> _handleSignUp(AuthSignUpEvent event, Emitter<AuthSignUpStateBloc> emit) async {
    try {
      emit(AuthSignUpLoadingState());
      final result = await userSignUpUseCase(
          params: UserSignUpEntity(
        country: event.country,
        firstName: event.firstName,
        lastName: event.lastName,
        userEmail: event.email,
        imageUrl: event.imgUrl,
        password: event.password,
        phoneNumber: event.phoneNumber,
        uUid: event.uUid,
      ));
      if (result != null && result.isSuccess) {
        emit(AuthSignUpSucessState(data: result.toString()));
      } else {
        emit(AuthSignupErrorState(errorMessage: result?.message ?? "Signup failed"));
      }
    } catch (error) {
      debugPrint("Error in _mapSignUpRequestedToState: $error");
      emit(AuthSignupErrorState(errorMessage: "Signup failed due to an unexpected error"));
      // yield AuthSignupErrorState(errorMessage: "Signup failed due to an unexpected error");
    }
  }

  void _handleImageSelected(ImagePickerEvent event, Emitter<AuthSignUpStateBloc> emit) async {
    try{
      final selectedImagePath = await ImageSelector.selectImage();
      debugPrint("selectedImagePath in bloc $selectedImagePath");
      if (selectedImagePath != null) {
        emit(AuthSignUpSucessState(imagePath: selectedImagePath));
      }
    }
    catch(error)
    {
      emit(AuthSignupErrorState(errorMessage: "Failed to select image"));
    }
  }

  Future<void> _handleSignIn(AuthSignInEvent event, Emitter<AuthSignUpStateBloc> emit) async {
    try {
      emit(AuthSignUpLoadingState());
      final result = await userSignInUseCase(params: UserSignInEntity(
        userEmail: event.email,
        userPassword: event.password,
      ));
      if (result != null && result.isSuccess) {
          emit(AuthSignUpSucessState(data: result.toString()));
      } else {
        emit(AuthSignupErrorState(errorMessage: result?.message ?? "Signin failed"));
      }
    } catch (error) {
      emit(AuthSignupErrorState(errorMessage: "Signin failed due to an unexpected error"));
    }
  }

}
