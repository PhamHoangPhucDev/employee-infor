import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'circle_icon_button.dart';

class ListTileIconButtonComponent extends StatelessWidget {
  ListTileIconButtonComponent({super.key, this.icon, this.title, this.func,this.subtitle});
  final List<List<dynamic>>? icon;
  final String? title;
  final String? subtitle;
  final VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: func,
      leading: CircleIconButton(
        icon: icon ?? HugeIcons.strokeRoundedBubbleChatQuestion,
        backgroundColor: AppColors.primary,
        iconColor: AppColors.textLight,
        iconSize: 22,
      ),
      title: Text(title ?? "",style: AppTypography.button(color: AppColors.text),),
      subtitle: Text(subtitle ?? "",style: AppTypography.smallbody(),),
      trailing: title != AppStrings.logoutButton
        ?HugeIcon(
          icon: HugeIcons.strokeRoundedArrowRight01,
          size: 22.sp,
          color: AppColors.primary,
        ):SizedBox.shrink(),
    );
  }
}