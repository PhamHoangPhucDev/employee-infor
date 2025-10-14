import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final List<List<dynamic>> icon;
  final double iconSize;
  final double? sizeCircle;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onPressed;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 16, // mặc định icon 16
    this.sizeCircle,
    this.backgroundColor = AppColors.backgroundInput,
    this.iconColor = AppColors.text,
  });

  @override
  Widget build(BuildContext context) {
    final double circleSize = sizeCircle ?? iconSize.sp + 13.sp;

    return SizedBox(
      width: circleSize,
      height: circleSize,
      child: ClipOval( //cắt gọn vùng tròn, tránh overflow lẻ pixel
        child: TextButton(
          onPressed: onPressed ?? () {},
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero, // bỏ padding mặc định
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // tránh vùng nhấn dư
          ),
          child: Center( //đảm bảo icon luôn nằm giữa, không cần Column
            child: HugeIcon(
              icon: icon,
              size: iconSize.sp,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
