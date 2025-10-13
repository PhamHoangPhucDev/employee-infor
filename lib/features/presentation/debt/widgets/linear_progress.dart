import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CustomLinearProgress extends StatelessWidget {
  final double value; // 0.0 → 1.0
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final String? label;
  final bool enableShimmer;
  final bool hidePercent;

  const CustomLinearProgress({
    super.key,
    required this.value,
    this.height = 10,
    this.backgroundColor = AppColors.disabled,
    this.progressColor = AppColors.primary,
    this.label,
    this.enableShimmer = true,
    this.hidePercent = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
         final gradient = LinearGradient(
          colors: [
            progressColor.withValues(alpha:0.4),
            progressColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
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
                  // Thanh chính có gradient
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: height,
                    width: 100.w * value,
                    decoration: BoxDecoration(
                       gradient: gradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                   // Lớp ánh sáng shimmer mờ chạy qua
                  if (enableShimmer)
                    Positioned.fill(
                      child: Shimmer.fromColors(
                        baseColor: Colors.transparent,
                        highlightColor: AppColors.background.withValues(alpha:0.5),
                        period: const Duration(seconds: 2),
                        child: Container(
                          height: height,
                          width: 100.w * value,
                          decoration: BoxDecoration(
                            color: AppColors.background.withValues(alpha:0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            if (hidePercent == false) Text("${(value * 100).toStringAsFixed(0)}%"),
          ],
        );
      }
    );
  }
}
