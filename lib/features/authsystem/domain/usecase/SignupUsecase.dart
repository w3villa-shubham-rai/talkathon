import 'package:flutter/material.dart';
import 'package:talkathon/core/usecase/usecase.dart';
import 'package:talkathon/features/authsystem/domain/entity/signupuserentity.dart';
import 'package:talkathon/features/authsystem/domain/repository/user_authsignup_base_repo.dart';
import 'package:talkathon/utils/success_type.dart';

class UserSignUpUseCase extends UseCase<SuccessType, UserSignUpEntity> {
  // final Object _repository;
   final UserSignUpBaseClassRepo _user_SignUp_repo;

  UserSignUpUseCase(this._user_SignUp_repo);

  @override
  Future<SuccessType?> call({UserSignUpEntity? params}) async {
    if (params == null) {
      debugPrint("params data here usecase ${params!.firstName},${params!.lastName},${params!.country},${params!.imageUrl},${params!.password},${params!.userEmail},${params!.phoneNumber}");
      return SuccessType(isSuccess: false, message: "Parameters cannot be null");
    }
    try {
       debugPrint("params data here usecase tryR${params!.firstName},${params!.lastName},${params!.country},${params!.imageUrl},${params!.password},${params!.userEmail},${params!.phoneNumber}");
     final result = await _user_SignUp_repo.signUp(params);
      return result;
    } catch (e) {
      return null;
    }
  }
}

class Params {}
