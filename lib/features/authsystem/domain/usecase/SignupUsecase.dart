import 'package:flutter/material.dart';
import 'package:talkathon/core/usecase/usecase.dart';
import 'package:talkathon/features/authsystem/domain/entity/signupuserentity.dart';
import 'package:talkathon/features/authsystem/domain/repository/user_authsignup_base_repo.dart';
import 'package:talkathon/utils/success_type.dart';

class UserSignUpUseCase extends UseCase<SuccessType, UserSignUpEntity> {
  // final Object _repository;
   final UserSignUpBaseClassRepo _repo;

  UserSignUpUseCase(this._repo);

  @override
  Future<SuccessType?> call({UserSignUpEntity? params}) async {
    if (params == null) {
      return SuccessType(isSuccess: false, message: "Parameters cannot be null");
    }
    try {
     final result = await _repo.signUp(params);
      return result;
    } catch (e) {
      return null;
    }
  }
}

class Params {}
