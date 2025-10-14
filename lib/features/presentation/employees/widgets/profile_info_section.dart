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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nguyễn Văn A',
                style: AppTypography.subtitle(),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.backgroundInput,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withValues(alpha: .1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedEdit02,
                  size: 16,
                  color: AppColors.icon,
                ),
              ),
            ],
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
                icon: HugeIcons.strokeRoundedLocation01,
                size: 16,
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
