import 'dart:math';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FeatureCardBase extends StatelessWidget {
  final IconData? backgroundIcon;
  final double? sizeIcon;
  final Widget child;
  final Color color;
  final double rotation;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  const FeatureCardBase({
    super.key,
    this.backgroundIcon,
    required this.child,
    this.color = AppColors.primary,
    this.rotation = -pi / 12,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.height,
    this.width,
    this.sizeIcon = 110,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary.withValues(alpha: .5), // màu border
            width: 2,           // độ dày border
          ),
          borderRadius: BorderRadius.circular(18), // bo góc
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // Nền icon phóng to
              Positioned(
                bottom: -20,
                right: -15,
                child: Transform.rotate(
                  angle: rotation,
                  child: Icon(
                    backgroundIcon,
                    size: sizeIcon,
                    color: color.withValues(alpha: .12),
                  ),
                ),
              ),
              // Nội dung chính
              Padding(
                padding: padding,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
