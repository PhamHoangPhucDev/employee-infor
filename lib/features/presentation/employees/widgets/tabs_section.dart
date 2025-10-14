import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../employees_controller.dart';

class TabsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;

  TabsHeaderDelegate({this.height = 50});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final controller = Get.find<EmployeesController>();
    final tabs = ['Experience', 'Skills', 'Projects', 'Contact'];

    return Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          height: height,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: .05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: List.generate(tabs.length, (index) {
              bool isSelected = controller.selectedTabIndex.value == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectTab(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected ? AppColors.textLight : AppColors.text,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
