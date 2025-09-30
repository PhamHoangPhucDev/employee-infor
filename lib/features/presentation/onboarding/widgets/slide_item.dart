import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SlideItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const SlideItem({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          height: 55.h,
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Image.asset(AppImages.onboarding_ellipse1),
              Image.asset(imagePath),
            ],
          ),
        ),
        SizedBox(width: 80.w,child: Text(title, style: AppTypography.subtitle(color: AppColors.primary),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),
        const SizedBox(height: 16),
        SizedBox(width: 75.w,child: Text(description, textAlign: TextAlign.center,style: AppTypography.body(),maxLines: 3,overflow: TextOverflow.ellipsis,)),
      ],
    );
  }
}