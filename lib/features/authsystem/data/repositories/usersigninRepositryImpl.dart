import 'package:talkathon/features/authsystem/domain/data_source/login_remote_data_source_base.dart';
import 'package:talkathon/features/authsystem/domain/entity/usersignin.dart';
import 'package:talkathon/features/authsystem/domain/repository/user_signiIn_BaseClass_Repo.dart';
import 'package:talkathon/utils/success_type.dart';

class AuthSignInImpl implements UserSignInBaseRepo{
  LoginDataSourceBase loginDataSourceBase;
  AuthSignInImpl(this.loginDataSourceBase);
  @override
  Future<SuccessType?> signIn(UserSignInEntity params) async{
   return await loginDataSourceBase.userSignIn(params);
  }
}