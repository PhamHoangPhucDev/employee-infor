import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/components/button/circle_icon_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ItemBenefitTile extends StatelessWidget {
  const ItemBenefitTile({super.key, required this.title, required this.subtitle, required this.icon});
  final String title;
  final String subtitle;
  final List<List<dynamic>> icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleIconButton(
            icon: icon,
            iconColor: AppColors.primary,
            iconSize: 25,
            sizeCircle: 60,
          ),
          title: Text(title, style: AppTypography.body(color: AppColors.primary)),
          subtitle: Text(subtitle, style: AppTypography.smallbody()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              VerticalDivider(thickness: 1,color: AppColors.backgroundInput,),
              HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01,color: AppColors.primary,)
            ],
          ),
          onTap: () {},
        ),
        Divider(color: AppColors.backgroundInput,)
      ],
    );
  }
}