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
    return InkWell(
      onTap: func,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleIconButton(
              icon: icon ?? HugeIcons.strokeRoundedBubbleChatQuestion,
              backgroundColor: AppColors.primary,
              iconColor: AppColors.textLight,
              iconSize: 22,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "",
                    style: AppTypography.button(color: AppColors.text),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Text(
                      subtitle!,
                      style: AppTypography.smallbody(),
                    ),
                ],
              ),
            ),
            if (title != AppStrings.logoutButton)
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 22.sp,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}