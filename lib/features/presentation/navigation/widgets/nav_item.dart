import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../navigation_controller.dart';

class NavItem extends StatelessWidget {
  NavItem({super.key,required this.controller,required this.icon,required this.label,required this.index});
  final NavigationController controller;
  final List<List<dynamic>> icon;
  final String label;
  final int index;

  final Color primaryColor = AppColors.background;
  final Color inactiveColor = AppColors.disabled;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(icon: icon,color: isSelected ? primaryColor : inactiveColor,),
          const SizedBox(height: 2),
          Text(
          label,
          // textAlign: TextAlign.center,
          // overflow: TextOverflow.ellipsis,
          style: isSelected
              ? AppTypography.smallbody(color: primaryColor)
              : AppTypography.caption(color: inactiveColor),
        ),
          const SizedBox(height: 2),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}