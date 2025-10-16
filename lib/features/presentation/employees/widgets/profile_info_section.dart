import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70, left: 20, right: 20),
      child: Column(
        children: [
          Text(
            'Nguyễn Văn A',
            style: AppTypography.subtitle(),
          ),
          SizedBox(height: 8),
          Text(
            'Product Designer',
            style: AppTypography.body(color: AppColors.text.withValues(alpha: .7)),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedWork,
                size: 16.sp,
                color: AppColors.icon,
              ),
              SizedBox(width: 4),
              Text(
                '3 năm kinh nghiệm',
                style: AppTypography.smallbody(color: AppColors.text.withValues(alpha: .5)),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedLocation01,
                size: 16.sp,
                color: AppColors.icon,
              ),
              SizedBox(width: 4),
              Text(
                'TP.HCM',
                style: AppTypography.smallbody(color: AppColors.text.withValues(alpha: .5)),
              ),
            ],
          ),
          SizedBox(height: 5,),
        ],
      ),
    );
  }
}
