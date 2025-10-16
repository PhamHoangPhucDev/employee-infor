import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../employees_controller.dart';

class TabsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  TabsHeaderDelegate({this.height = 5});

  @override
  double get minExtent => height.h;
  @override
  double get maxExtent => height.h;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final controller = Get.find<EmployeesController>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.background,
      ),
      child:TabBar(
        controller: controller.tabController,
        isScrollable: true, // Cho phép cuộn ngang khi nhiều tab
        tabAlignment: TabAlignment.start, // giữ tab dính sát trái
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.icon,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        tabs: controller.tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
