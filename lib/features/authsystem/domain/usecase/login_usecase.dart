import 'package:talkathon/core/usecase/usecase.dart';
import 'package:talkathon/features/authsystem/domain/entity/usersignin.dart';
import 'package:talkathon/features/authsystem/domain/repository/user_signiIn_BaseClass_Repo.dart';
import 'package:talkathon/utils/success_type.dart';

class UserSignInUseCase extends UseCase<SuccessType, UserSignInEntity> {
  final UserSignInBaseRepo _userSignInBaseRepo;
  UserSignInUseCase(this._userSignInBaseRepo);

  @override
  Future<SuccessType?> call({UserSignInEntity? params}) async {
    if (params == null) {
      return SuccessType(isSuccess: false, message: "Parameters cannot be null",);
    }
    try {
      final result = await _userSignInBaseRepo.signIn(params);
      return result;
    } catch (e) {
      return Future.value(SuccessType(
        isSuccess: false,
        message: "An error occurred during sign up",
      ));
    }
  }
}
