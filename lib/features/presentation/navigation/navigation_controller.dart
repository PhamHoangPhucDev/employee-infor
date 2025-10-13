import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../notification/notification_controller.dart';
import '../profile/profile_controller.dart';
import '../task/task_controller.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    Get.lazyPut(() => HomeController(), fenix: true);
  }
  
  
  void changePage(int index) {
    if(currentIndex.value != index) {
      currentIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // LazyPut controller cho page được chọn lần đầu
      switch (index) {
        case 0:
          Get.lazyPut(() => HomeController(), fenix: true);
          break;
        case 1:
          Get.lazyPut(() => TaskController(), fenix: true);
          break;
        case 2:
          Get.lazyPut(() => NotificationController(), fenix: true);
          break;
        case 3:
          Get.lazyPut(() => ProfileController(), fenix: true);
          break;
      }
    }
  }
}
