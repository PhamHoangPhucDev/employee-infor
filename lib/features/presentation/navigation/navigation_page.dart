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
import 'widgets/nav_item.dart';

class NavigationPage extends GetView<NavigationController> {
  NavigationPage({super.key});

  final List<Widget> pages = [
    HomePage(),
    TaskPage(),
    SizedBox.shrink(), // Slot cho FAB
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      extendBody: true,
      body: pages[controller.currentIndex.value],
      bottomNavigationBar:BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: AppColors.primary,
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: NavItem(controller: controller,icon: HugeIcons.strokeRoundedHome07,label: 'Trang Chủ',index:  0)),
            Expanded(child: NavItem(controller: controller,icon: HugeIcons.strokeRoundedTaskDaily01,label: 'Công Việc',index:  1)),
            const SizedBox(width: 48), // chừa chỗ cho FAB
            Expanded(child: NavItem(controller: controller,icon: HugeIcons.strokeRoundedNotification01,label: 'Thông Báo',index:  3)),
            Expanded(child: NavItem(controller: controller,icon: HugeIcons.strokeRoundedUser,label: 'Cá Nhân',index:  4)),
          ],
        ),
      ),
      
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400), // thời gian mờ dần
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child), // hiệu ứng phóng nhẹ
        ),
        child: FloatingActionButton(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
}