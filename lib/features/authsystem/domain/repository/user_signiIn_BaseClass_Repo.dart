import 'package:talkathon/features/authsystem/domain/entity/usersignin.dart';
import 'package:talkathon/utils/success_type.dart';

abstract interface class UserSignInBaseRepo {
  Future<SuccessType?> signIn(UserSignInEntity params);

}
