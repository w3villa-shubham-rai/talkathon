import 'package:talkathon/features/authsystem/domain/data_source/auth_remote_data_source_base.dart';
import 'package:talkathon/features/authsystem/domain/entity/signupuserentity.dart';
import 'package:talkathon/features/authsystem/domain/repository/user_authsignup_base_repo.dart';
import 'package:talkathon/utils/success_type.dart';

class AuthRepositoryImpl implements UserSignUpBaseClassRepo{
  final AuthremoteInterfaceCall _authRemote;
   AuthRepositoryImpl(this._authRemote);
  @override
  Future<SuccessType?> signUp(UserSignUpEntity params) async {
    return await _authRemote.signUpDataSource(params);
    
    // debugPrint("Country: ${params.country}");
    // debugPrint("First Name: ${params.firstName}");
    // debugPrint("Last Name: ${params.lastName}");
    // debugPrint("Email: ${params.userEmail}");
    // debugPrint("Image URL: ${params.imageUrl}");
    // debugPrint("Password: ${params.password}");
    // debugPrint("Phone Number: ${params.phoneNumber}");
    // debugPrint("UUID: ${params.uUid}");

    // return
    //   SuccessType(
    //   isSuccess: true,
    //   message: "Sign-up successful",
    //   data: {
    //     "country": params.country,
    //     "firstName": params.firstName,
    //     "lastName": params.lastName,
    //     "userEmail": params.userEmail,
    //     "imageUrl": params.imageUrl,
    //     "password": params.password,
    //     "phoneNumber": params.phoneNumber,
    //     "uUid": params.uUid,
    //   },
    // );
    // return SuccessType(data: Map<String,String> j={'ram';3},isSuccess: true,message: "ss",statusCode: "200")
  }



}