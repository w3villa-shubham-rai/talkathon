import 'package:talkathon/features/authsystem/domain/entity/signupuserentity.dart';
import 'package:talkathon/utils/success_type.dart';

abstract interface class UserSignUpBaseClassRepo{
  Future<SuccessType?>signUp(UserSignUpEntity params);
}