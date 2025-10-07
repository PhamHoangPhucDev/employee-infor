import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/appBar_component.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/text_field_component.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key,required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: title,),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFieldComponent(
              controller: TextEditingController(),
              label: AppStrings.oldPasswordLabel,
              isPassword: true,
            ),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){},
              child: Text(AppStrings.forgetPasswordButton,style: AppTypography.smallbody(color: AppColors.primary,decoration: TextDecoration.underline),),
            ),
            TextFieldComponent(
              controller: TextEditingController(),
              label: AppStrings.newPasswordLabel,
              isPassword: true,
            ),
            TextFieldComponent(
              controller: TextEditingController(),
              label: AppStrings.confirmPasswordLabel,
              isPassword: true,
            ),
            SizedBox(height: 5.h),
            Center(
              child: TextButtonComponent(
                title: AppStrings.changePasswordTitle,
                onPressed: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }
}