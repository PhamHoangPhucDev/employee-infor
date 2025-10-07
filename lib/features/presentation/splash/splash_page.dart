import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/theme/app_colors.dart';
import '../../domain/services/auth_service.dart';
import '../../../core/routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(milliseconds: 800), () {
    //   final authService = Get.find<AuthService>();
    //   if (authService.isLoggedIn) {
    //     Get.offAllNamed(AppRoutes.home);
    //   } else {
    //     Get.offAllNamed(AppRoutes.login);
    //   }
    // });
      Future.delayed(const Duration(milliseconds: 800), () {
        Get.offAllNamed(AppRoutes.welcome);
      });

    return Scaffold(
      body: Container(
        color: AppColors.primary,
        width: 100.w,
        height: 100.h,
        child: Image.asset(
          AppImages.logo,
        ),
      ),
    );
  }
}
