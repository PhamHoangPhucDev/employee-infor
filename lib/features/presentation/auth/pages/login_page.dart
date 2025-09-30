import 'package:employee_infor/core/components/app_circleIconButton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/app_appBar.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_textField.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final emailCtrl = TextEditingController(text: 'admin@company.com'); // demo
    final passCtrl = TextEditingController(text: '1234');

    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.loginButton,showBack: false,),
      body: Padding(
        padding: EdgeInsets.only(left: 20.sp,right: 20.sp,),
        child: Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(AppStrings.welcomeTitle, style: AppTypography.subtitle(color:AppColors.primary))
              ),
              SizedBox(height: 30),
          
              AppTextfieldComponent(
                label: "${AppStrings.emailLabel} hoặc ${AppStrings.mobileNumberLabel}",
                hintText: "Nhập ${AppStrings.emailLabel} hoặc ${AppStrings.mobileNumberLabel}",
                controller: emailCtrl,
              ),
              SizedBox(height: 20),
          
              AppTextfieldComponent(
                label: AppStrings.passwordLabel,
                hintText: "Nhập ${AppStrings.passwordLabel}",
                isPassword: true,
                controller: passCtrl,
              ),
              SizedBox(height: 5),
              
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: (){},
                  child: Text(AppStrings.forgetPasswordButton,style: AppTypography.body(color: AppColors.primary),)
                ),
              ),
              SizedBox(height: 20),
          
              controller.isLoading.value
                ? const CircularProgressIndicator()
                : AppButtonComponent(
                  title: AppStrings.loginButton,
                  onPressed: () => controller.login(emailCtrl.text, passCtrl.text),
                ),
              SizedBox(height: 20,),
              Text('hoặc đăng nhập với',style: AppTypography.smallbody(),),
              SizedBox(height: 20,),
              AppCircleIconButton(
                icon: HugeIcons.strokeRoundedFingerAccess, 
                backgroundColor: AppColors.primary,
                iconColor: AppColors.background,
                size: 28,
                iconSize: 22,
                onPressed: (){ 
                  print("Đang quét dấu vân tay đăng nhập!");
                },
              ),
              SizedBox(height: 20,),
              Text.rich(
                TextSpan(
                  text: "Bạn chưa có tài khoản? ",
                  style: AppTypography.smallbody(),
                  children: [
                    TextSpan(
                      text: AppStrings.signupButton,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.signup);
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
