import 'package:talkathon/features/authsystem/domain/entity/usersignin.dart';
import 'package:talkathon/utils/success_type.dart';

abstract interface class LoginDataSourceBase{
  Future<SuccessType?> userSignIn(UserSignInEntity params);
}