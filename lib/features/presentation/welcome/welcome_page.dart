import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/app_button.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'welcome_controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AppImages.logoLight,
              width:70.w,
              height: 40.h,
            ),
            Positioned(
              bottom: 10.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      AppStrings.welcomeMessage,
                      style: AppTypography.body(color:AppColors.primary),
                      textAlign: TextAlign.center
                    ),
                  ),
                  SizedBox(height: 40),
                  AppButtonComponent(
                    title: AppStrings.getstartedButton,
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.onboarding);
                    },
                    borderRadius: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
