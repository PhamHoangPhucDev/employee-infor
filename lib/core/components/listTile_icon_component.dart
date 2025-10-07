import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class ListTileIconComponent extends StatelessWidget {
  ListTileIconComponent({super.key, this.icon, this.title, this.func,this.subtitle,this.trailing});
  final List<List<dynamic>>? icon;
  final String? title;
  final String? subtitle;
  final VoidCallback? func;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: func,
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10)
        ),
        
        child: HugeIcon(
          icon: icon?? HugeIcons.strokeRoundedBubbleChatQuestion,
          color: AppColors.textLight,
        ),
      ),
      title: Text(title ?? "",style: AppTypography.button(color: AppColors.text),),
      subtitle: Text(subtitle ?? "",style: AppTypography.smallbody(),),
      trailing: trailing
    );
  }
}