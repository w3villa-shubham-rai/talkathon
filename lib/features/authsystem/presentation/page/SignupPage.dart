import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/core/theme/app_pallet.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authbloc.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authevent.dart';
import 'package:talkathon/features/authsystem/presentation/bloc/authstate.dart';
import 'package:talkathon/utils/component/customTextFormField.dart';
import 'package:talkathon/utils/component/custom_snackbar.dart';
import 'package:talkathon/utils/imagepicker.dart';
import 'package:talkathon/utils/loaderframe.dart';
import 'package:talkathon/utils/padding_marging.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<TextEditingController> listTextEditingController = [];
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    listTextEditingController = List.generate(6, (index) {
      return TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthSignupBloc, AuthSignUpStateBloc>(
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
            return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 67,
                          width: 67,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cobaltBlue,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child:
                          state is AuthSignUpSucessState && state.imagePath != null
                              ? Image.file(File(state.imagePath!), fit: BoxFit.cover)
                              : const SizedBox(),
                          // Image.network(
                          //   'https://images.unsplash.com/photo-1579783483458-83d02161294e?q=80&w=2897&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          //   fit: BoxFit.cover,
                          // ),
                        ).paddingOnly(top: 20),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                              onTap: () {
                               context.read<AuthSignupBloc>().add(
                                 ImagePickerEvent(),
                               );
                              },
                              child: const Icon(Icons.camera_alt_rounded,
                                  color: AppColors.darkRedColor)),
                        )
                      ],
                    ),
                    Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          formFieldWidget(
                              labelName: "First Name",
                              textEditingController:
                                  listTextEditingController[0]),
                          formFieldWidget(
                              labelName: "Last Name",
                              textEditingController:
                                  listTextEditingController[1]),
                          formFieldWidget(
                              labelName: "Email",
                              textEditingController:
                                  listTextEditingController[2]),
                          formFieldWidget(
                              labelName: "Password",
                              textEditingController:
                                  listTextEditingController[3]),
                          formFieldWidget(
                              labelName: "Country",
                              textEditingController:
                                  listTextEditingController[4]),
                          formFieldWidget(
                              labelName: "Phone",
                              textEditingController:
                                  listTextEditingController[5]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        if (_globalKey.currentState!.validate()) {// All fields are valid, proceed with your action
                          String? imagePath;
                          if (state is AuthSignUpSucessState) {
                            imagePath = state.imagePath;
                          }
                          context.read<AuthSignupBloc>().add(
                                AuthSignUpEvent(
                                  firstName: listTextEditingController[0].text.trim(),
                                  lastName: listTextEditingController[1].text.trim(),
                                  email: listTextEditingController[2].text.trim(),
                                  password: listTextEditingController[3].text.trim(),
                                  country: listTextEditingController[4].text.trim(),
                                  phoneNumber: listTextEditingController[5].text.trim(),
                                  imgUrl: imagePath??"",
                                  uUid: '',
                                ),
                              );
                          debugPrint("Form validated successfully. Perform your action here.");
                        } else {
                          // Validation failed
                          debugPrint("Form validation failed. Please fill in all required fields.");
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 250,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: AppColors.cobaltBlue,
                        ),
                        child: const Center(
                          child: Text(
                            "Finish",
                            style:TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 20, vertical: 10),
            );
          }
        },
      ),
    ));
  }

  Widget formFieldWidget(
      {required String labelName,
      required TextEditingController textEditingController}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              labelName,
              style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter $labelName";
                }
                return null;
              },
              height: 45,
              controller: textEditingController,
              fillColors: AppColors.whiteColor,
              borderSide: const BorderSide(color: AppColors.greyColor),
              hintText: labelName,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }
}
