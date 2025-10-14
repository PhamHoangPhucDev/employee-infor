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
import '../../../../core/utils/validator_util.dart';
import '../auth_controller.dart';

class SignupPage extends GetView<AuthController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.newAccountTitle),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() => SingleChildScrollView(
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFieldComponent(
                  label: AppStrings.fullNameLabel,
                  hintText: "Nhập ${AppStrings.fullNameLabel}",
                  controller: controller.fullnameCtrl,
                  validator: (value) => ValidatorUtil.validateFullname(value, lang: 'vi'),
                ),
            
                const SizedBox(height: 5),
                TextFieldComponent(
                  label: AppStrings.emailLabel,
                  hintText: "Nhập ${AppStrings.emailLabel}",
                  controller: controller.emailCtrl,
                  validator: (value) => ValidatorUtil.validateEmail(value, lang: 'vi'),
                ),
            
                const SizedBox(height: 5),
                TextFieldComponent(
                  label: AppStrings.mobileNumberLabel,
                  hintText: "Nhập ${AppStrings.mobileNumberLabel}",
                  controller: controller.mobileCtrl,
                  validator: (value) => ValidatorUtil.validateMobile(value, lang: 'vi'),
                ),
            
                const SizedBox(height: 5),
                TextFieldComponent(
                  label: AppStrings.birthdayLabel,
                  hintText: "DD/MM/YYYY",
                  controller: controller.birthdayCtrl,
                  validator: (value) => ValidatorUtil.validateBirthday(value, lang: 'vi'),
                ),
            
                const SizedBox(height: 5),
                TextFieldComponent(
                  label: AppStrings.passwordLabel,
                  hintText: "Nhập ${AppStrings.passwordLabel}",
                  controller: controller.passwordCtrl,
                  isPassword: true,
                  validator: (value) => ValidatorUtil.validatePassword(value, minLength: 6),
                ),
            
                const SizedBox(height: 5),
                TextFieldComponent(
                  label: AppStrings.confirmPasswordLabel,
                  hintText: "Xác nhận mật khẩu",
                  controller: controller.confirmPasswordCtrl,
                  isPassword: true,
                  validator: (value) => ValidatorUtil.validateConfirmPassword(value,controller.passwordCtrl.text, lang: "vi"),
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
                    onPressed: controller.signup,
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
          ),
        )),
      ),
    );
  }
}