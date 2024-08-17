import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authbloc.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authevent.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authstate.dart';
import 'package:talkathon/features/authsystem/presentation/page/SignupPage.dart';
import 'package:talkathon/utils/component/customTextFormField.dart';
import 'package:talkathon/utils/component/custom_snackbar.dart';
import 'package:talkathon/utils/component/extension_of_size.dart';
import 'package:talkathon/utils/loaderframe.dart';
import 'package:talkathon/utils/padding_marging.dart';

import '../../../../core/theme/app_pallet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userPasswordController=TextEditingController();
  final TextEditingController _userEmailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:BlocConsumer<AuthSignupBloc, AuthSignUpStateBloc>(
          listener: (context, state) {
            if (state is AuthSignupErrorState) {
              showSnackBar(context, "Error in signUp page");
            } else if (state is AuthSignUpSucessState) {
              // listTextEditingController.clear();
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Blogpage()),(Route<dynamic> route) => false,
              // );
            }
          },
          builder: (context, state) {
          if (state is AuthSignUpLoadingState) {
            return const Center(child: LoaderFrame());
          } else {
          return  Column(
            children: [
              Lottie.asset('assets/animation/login.json', height: 300
              ),
              CustomTextFormField(
                controller:  _userEmailController,
                height: 45,
                fillColors: AppColors.whiteColor,
                borderSide: const BorderSide(color: AppColors.greyColor),
                hintText: "Enter the Email",
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              // 5.bh,
              25.bh,
              CustomTextFormField(
                controller: _userPasswordController,
                height: 45,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                fillColors: AppColors.whiteColor,
                borderSide: const BorderSide(color: AppColors.greyColor),
                hintText: "Enter password",
                suffixIcon: const Icon(Icons.visibility),
              ),
              25.bh,
              InkWell(
                onTap: () {
                  context.read<AuthSignupBloc>().add(
                      AuthSignInEvent(
                        password: _userPasswordController.text.toString(),
                        email: _userEmailController.text.toString(),
                      ),
                  );
                },
                child: Container(
                  height: 45,
                  width: 250,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: AppColors.cobaltBlue
                  ),
                  child: const Center(child: Text("LOGIN",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.whiteColor),)),
                ),
              ),
              25.bh,
              // Container(
              //   height: 45,
              //   width: 250,
              //   decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(5)),
              //       color: AppColors.pigmentRed,
              //   ),
              //   child: const Center(child: Text("Create an Account",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
              // ),
              20.bh,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Create Account",style: TextStyle(fontSize: 12,color: AppColors.blackColor,fontWeight: FontWeight.w300),),
                  5.bw,

                   InkWell(
                    onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(),)),
                    child: const Text("here",style: TextStyle(fontSize: 12,color: AppColors.pigmentRed,fontWeight: FontWeight.w500),))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  loginWithThirdAppLibrary(colorOfBtn: AppColors.cobaltBlue,btnIcon: const Icon(Icons.facebook,color: AppColors.antiFlashWhite,)),
                  loginWithThirdAppLibrary(colorOfBtn: AppColors.cobaltBlue,btnIcon:Image.network('http://pngimg.com/uploads/google/google_PNG19635.png', fit:BoxFit.cover,width: 30,height: 30,)),
                  loginWithThirdAppLibrary(colorOfBtn: AppColors.cobaltBlue,btnIcon: const Icon(Icons.phone,color:AppColors.whiteColor)),
                  loginWithThirdAppLibrary(colorOfBtn: AppColors.cobaltBlue,btnIcon: const Icon(Icons.message,color:AppColors.whiteColor)),

                ],
              ).paddingSymmetric(horizontal: 40,vertical: 30)
            ],
          ).paddingAll(30);
         }
    }
      )


    );

  }
  
  Widget loginWithThirdAppLibrary({required Color colorOfBtn, required  Widget btnIcon,}){
    return Container(
      height: 57,
      width: 57,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorOfBtn,
      ),
      child: Center(child: btnIcon,),
    );
  }
}
