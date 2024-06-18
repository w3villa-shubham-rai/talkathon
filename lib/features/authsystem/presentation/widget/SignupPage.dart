import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:talkathon/utils/component/customTextFormField.dart';
import 'package:talkathon/utils/component/extension_of_size.dart';
import 'package:talkathon/utils/padding_marging.dart';

import '../../../../core/theme/app_pallet.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 1,
                    color: AppColors.greyColor
                )
              ]
          ),
          child: Column(
            children: [
              Container(
                height: 67,
                width: 67,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cobaltBlue,
                ),
              ),
              formFieldWidget(labelName: "First Name"),
              formFieldWidget(labelName: "Last Name"),
              formFieldWidget(labelName: "Email"),
              formFieldWidget(labelName: "Password"),
              formFieldWidget(labelName: "Country"),

            ],
          )
        ).paddingSymmetric(horizontal: 20,vertical: 10),
      )
    );
  }

TextEditingController textEditingSignUpController=TextEditingController();
  Widget formFieldWidget({required String labelName,}){
    return  Row(
      children: [
          Expanded(
              flex: 2,
             child: Text(labelName,style: const TextStyle(fontSize: 16,color: AppColors.blackColor,fontWeight: FontWeight.w500),)),
         5.bw,
        Expanded(
          flex: 5,
          child: CustomTextFormField(
            controller: textEditingSignUpController,
            height: 45,
            fillColors: AppColors.whiteColor,
            borderSide: const BorderSide(color: AppColors.greyColor),
            hintText: labelName,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 20,horizontal: 20);
  }
}
