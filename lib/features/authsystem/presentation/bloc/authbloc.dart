import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/authsystem/domain/entity/signupuserentity.dart';
import 'package:talkathon/features/authsystem/domain/usecase/SignupUsecase.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authevent.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authstate.dart';

class AuthSignupBloc extends Bloc<AuthSignUpEvent, AuthSignUpStateBloc> {
  final UserSignUpUseCase userSignUpUseCase;
  AuthSignupBloc({required this.userSignUpUseCase}) : super(AuthSignUpIntialState()) {
      on<AuthSignUpEvent>(_handleSignUp);
  }

  Future<void> _handleSignUp(
      AuthSignUpEvent event, Emitter<AuthSignUpStateBloc> emit) async {
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
        emit(AuthSignUpSucessState(result.toString()));
      } else {
        emit(AuthSignupErrorState(errormessage: result?.message ?? "Signup failed"));
      }
    } catch (error) {
      debugPrint("Error in _mapSignUpRequestedToState: $error");
      emit(AuthSignupErrorState(errormessage: "Signup failed due to an unexpected error"));
      // yield AuthSignupErrorState(errorMessage: "Signup failed due to an unexpected error");
    }
  }
}
