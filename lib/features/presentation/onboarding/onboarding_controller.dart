import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../data/models/prCode_model.dart';
import '../../domain/services/auth_service.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  var isLastPage = false.obs;
  final PageController pageController = PageController();
  final List<PrCodeModel> slides = [
    PrCodeModel(name: "Chào mừng bạn đến với Cổng thông tin nhân viên",subname: "Một nền tảng số hiện đại, giúp bạn kết nối với công việc, quản lý thông tin cá nhân và tiếp cận mọi tiện ích ngay trong tầm tay.",body1: AppImages.onboarding_slide1),
    PrCodeModel(name: "Chấm công dễ dàng, linh hoạt mọi lúc",subname: "Không còn lo quên điểm danh. Ứng dụng hỗ trợ chấm công nhanh chóng, quản lý ca trực rõ ràng và giúp bạn chủ động trong lịch làm việc hàng ngày.",body1: AppImages.onboarding_slide2),
    PrCodeModel(name: "Minh bạch và tiện lợi trong quản lý thu nhập",subname: "Xem bảng lương, thưởng và các khoản phụ cấp chi tiết bất cứ lúc nào. Mọi thông tin đều minh bạch, giúp bạn yên tâm và an tâm làm việc hơn.",body1: AppImages.onboarding_slide3),
  ];

  void updatePage(int index) {
    currentPage.value = index;
    isLastPage.value = index == 2; // ví dụ có 3 slide
  }

  void goToLogin() async {
    final authService = Get.find<AuthService>();
    // await authService.setFirstLaunchFalse();
    Get.offAllNamed(AppRoutes.login);
  }

  void nextPage(PageController pageController) {
    if (isLastPage.value) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }
}
