import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/button/circle_icon_button.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/text_field_component.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../auth_controller.dart';
import '../widgets/wave_clipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final controller = Get.find<AuthController>();
  final emailCtrl = TextEditingController(text: 'admin@company.com'); // demo
  final passCtrl = TextEditingController(text: '1234');

  bool _rememberMe = false;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primaryRed,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: .3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Section
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        // padding: EdgeInsets.all(16),
                        // decoration: BoxDecoration(
                        //   color: AppColors.background.withValues(alpha: .2),
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        child: Image.asset(
                          AppImages.logo,
                          height: 80,
                        )
                      ),
                      SizedBox(height: 12),
                      Text(
                        'MÔI TRƯỜNG Á CHÂU',
                        style: AppTypography.subtitle(color: AppColors.textLight),
                      ),
                    ],
                  ),
                ),
            
                // Animated Wave
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: WaveClipper(_waveController.value),
                      child: Container(
                        height: 10.h,
                        color: AppColors.background,
                      ),
                    );
                  },
                ),
            
                // White Content Section/ form
                Container(
                  color: AppColors.background,
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 32),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.loginButton,
                        style: AppTypography.subtitle(),
                      ),
                      SizedBox(height: 16),
            
                      TextFieldComponent(
                        label: "${AppStrings.emailLabel} hoặc ${AppStrings.mobileNumberLabel}",
                        hintText: "Nhập ${AppStrings.emailLabel} hoặc ${AppStrings.mobileNumberLabel}",
                        controller: emailCtrl,
                      ),
                      SizedBox(height: 20),
                  
                      TextFieldComponent(
                        label: AppStrings.passwordLabel,
                        hintText: "Nhập ${AppStrings.passwordLabel}",
                        isPassword: true,
                        controller: passCtrl,
                      ),
                      SizedBox(height: 5),
            
                      // Remember me & Forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  activeColor: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Lưu tài khoản',
                                style: AppTypography.body(color: AppColors.disabled),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              AppStrings.forgetPasswordButton,
                              style: AppTypography.body(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
            
                      // Login Button
                      controller.isLoading.value
                        ? const CircularProgressIndicator()
                        :
                         TextButtonComponent(
                          width: 100.w,
                          title: AppStrings.loginButton,
                          onPressed: () => controller.login(emailCtrl.text, passCtrl.text),
                        ),
                      SizedBox(height: 10),
            
                      // Sign Up Link
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
                      ),
                      SizedBox(height: 5),
            
                      // Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.backgroundInput,endIndent: 10,)),
                          Text("hoặc",style: AppTypography.smallbody(color: AppColors.disabled),),
                          Expanded(child: Divider(color: AppColors.backgroundInput,indent: 10,)),
                        ],
                      ),
                      SizedBox(height: 5),
                      CircleIconButton(
                        icon: HugeIcons.strokeRoundedFingerAccess, 
                        backgroundColor: AppColors.primary,
                        iconColor: AppColors.background,
                        iconSize: 22,
                        onPressed: (){ 
                          print("Đang quét dấu vân tay đăng nhập!");
                        },
                      ),
                      SizedBox(height: 5),
            
                      // Social Login
                      Text(
                        'Đăng nhập bằng tài khoản khác',
                        style: AppTypography.smallbody(color: AppColors.disabled),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleIconButton(
                            icon: HugeIcons.strokeRoundedFacebook02,
                            backgroundColor: AppColors.primary,
                            iconColor: AppColors.background,
                            iconSize: 20,
                            onPressed: () {},
                          ),
                          SizedBox(width: 16),
                          CircleIconButton(
                            icon: HugeIcons.strokeRoundedLink05,
                            backgroundColor: AppColors.info,
                            iconColor: AppColors.background,
                            iconSize: 20,
                            onPressed: () {},
                          ),
                          SizedBox(width: 16),
                          CircleIconButton(
                            icon: HugeIcons.strokeRoundedBubbleChat,
                            backgroundColor: AppColors.secondary,
                            iconColor: AppColors.background,
                            iconSize: 20,
                            onPressed: () {},
                          ),
                          SizedBox(width: 16),
                          CircleIconButton(
                            icon: HugeIcons.strokeRoundedMail01,
                            backgroundColor: AppColors.primary,
                            iconColor: AppColors.background,
                            iconSize: 20,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


