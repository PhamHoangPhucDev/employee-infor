import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../theme/app_colors.dart';

class AppCircleIconButton extends StatelessWidget {
  final List<List<dynamic>> icon;
  final double size; // đường kính button
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const AppCircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 22,               // mặc định 27x27
    this.iconSize = 16,           // mặc định icon 15
    this.backgroundColor = AppColors.backgroundInput,
    this.iconColor = AppColors.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.sp,
      height: size.sp,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero, // bỏ padding mặc định
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: icon,
              size: iconSize.sp,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
