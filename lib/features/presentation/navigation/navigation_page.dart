import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/app_colors.dart';
import '../home/home_page.dart';
import '../notification/notification_page.dart';
import '../profile/profile_page.dart';
import '../task/task_page.dart';
import 'navigation_controller.dart';

class NavigationPage extends GetView<NavigationController> {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              TaskPage(),
              NotificationPage(),
              ProfilePage(),
            ],
          ),
      bottomNavigationBar: Obx(() =>CurvedNavigationBar(
        index: controller.currentIndex.value,
        height: 55,
        backgroundColor: AppColors.background,
        color: AppColors.primary,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index){
          controller.changePage(index);
        },
        items: [
          HugeIcon(icon: HugeIcons.strokeRoundedHome07,color: AppColors.background,),
          HugeIcon(icon: HugeIcons.strokeRoundedTaskDaily01,color: AppColors.background,),
          HugeIcon(icon: HugeIcons.strokeRoundedNotification01,color: AppColors.background,),
          HugeIcon(icon: HugeIcons.strokeRoundedUser,color: AppColors.background,),
        ]
      )),
      
      floatingActionButton: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400), // thời gian mờ dần
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child), // hiệu ứng phóng nhẹ
        ),
        child: controller.currentIndex.value == 0
          ? FloatingActionButton(
              key: const ValueKey('scanButton'), // mỗi widget khác nhau nên cần key
              onPressed: () {
                // xử lý hành động quét chấm công
              },
              backgroundColor: AppColors.primary,
              shape: const CircleBorder(),
              elevation: 6,
              tooltip: "Quét chấm công",
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedFingerAccess,
                color: AppColors.background,
                size: 22.sp,
              ),
            )
          : const SizedBox.shrink(key: ValueKey('emptyButton'),),
        )
      ),
    );
  }
}