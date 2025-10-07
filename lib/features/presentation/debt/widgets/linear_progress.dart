import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CustomLinearProgress extends StatelessWidget {
  final double value; // 0.0 → 1.0
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final String? label;

  const CustomLinearProgress({
    super.key,
    required this.value,
    this.height = 10,
    this.backgroundColor = AppColors.disabled,
    this.progressColor = AppColors.primary,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.body()),
          const SizedBox(height: 4),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                height: height,
                color: backgroundColor,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: height,
                width: 100.w * value,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 4),
        // Text("${(value * 100).toStringAsFixed(0)}%"),
      ],
    );
  }
}
