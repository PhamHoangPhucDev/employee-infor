import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class FollowStatsSection extends StatelessWidget {
  const FollowStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '200 followers',
            style: AppTypography.smallbody(color: AppColors.text.withValues(alpha: .6)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.icon,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            '200 followers',
            style: AppTypography.smallbody(color: AppColors.text.withValues(alpha: .6)),
          ),
        ],
      ),
    );
  }
}
