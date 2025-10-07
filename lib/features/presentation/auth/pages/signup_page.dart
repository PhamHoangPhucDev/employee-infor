import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/components/appBar_component.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/text_field_component.dart';
import '../../../../core/components/button/circle_icon_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../auth_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final fullnameCtrl = TextEditingController(text: 'Nguyen Van A'); 
    final passCtrl = TextEditingController(text: '1234');
    final emailCtrl = TextEditingController(text: 'admin@company.com');
    final mobileNumberCtrl = TextEditingController(text: '0999999999');
    final birthdayCtrl = TextEditingController(text: '20/10/2025');

    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.newAccountTitle),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFieldComponent(
                label: AppStrings.fullNameLabel,
                hintText: "Nhập ${AppStrings.fullNameLabel}",
                controller: fullnameCtrl,
              ),
              
              const SizedBox(height: 5),
              TextFieldComponent(
                label: AppStrings.passwordLabel,
                hintText: "Nhập ${AppStrings.passwordLabel}",
                isPassword: true,
                controller: passCtrl,
              ),
          
              const SizedBox(height: 5),
              TextFieldComponent(
                label: AppStrings.emailLabel,
                hintText: "Nhập ${AppStrings.emailLabel}",
                controller: emailCtrl,
              ),
          
              const SizedBox(height: 5),
              TextFieldComponent(
                label: AppStrings.mobileNumberLabel,
                hintText: "Nhập ${AppStrings.mobileNumberLabel}",
                controller: mobileNumberCtrl,
              ),
          
              const SizedBox(height: 5),
              TextFieldComponent(
                label: AppStrings.birthdayLabel,
                hintText: "DD/MM/YYYY",
                controller: birthdayCtrl,
              ),
              
              const SizedBox(height: 20),
              
              Text("Bằng cách tiếp tục, bạn đồng ý với",style: AppTypography.smallbody()),
              Text.rich(
                TextSpan(
                  text: "",
                  style:  AppTypography.smallbody(),
                  children: [
                    TextSpan(
                      text: "Điều khoản sử dụng",
                      style:  AppTypography.smallbody(color: AppColors.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Điều khoản');
                        },
                    ),
                    TextSpan(text:" và "),
                    TextSpan(
                      text: "Chính sách quyền riêng tư.",
                      style: AppTypography.smallbody(color: AppColors.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Chính sách');
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
          
              controller.isLoading.value
                ? const CircularProgressIndicator()
                : TextButtonComponent(
                  title: AppStrings.signupButton,
                  onPressed: () => controller.login(emailCtrl.text, passCtrl.text),
                ),
              SizedBox(height: 15,),
              Text('hoặc đăng ký với',style: AppTypography.smallbody()),
              SizedBox(height: 15,),
              CircleIconButton(
                icon: HugeIcons.strokeRoundedFingerAccess, 
                backgroundColor: AppColors.primary,
                iconColor: AppColors.background,
                iconSize: 22,
                onPressed: (){ 
                  print("Đang quét dấu vân tay đăng nhập!");
                },
              ),
              SizedBox(height: 15,),
              Text.rich(
                TextSpan(
                  text: "Đã có tài khoản? ",
                  style: AppTypography.smallbody(),
                  children: [
                    TextSpan(
                      text: AppStrings.loginButton,
                      style: AppTypography.smallbody(color: AppColors.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAllNamed(AppRoutes.login);
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        )),
      ),
    );
  }
}