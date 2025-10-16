import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBack;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  const AppBarComponent({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.showBack = true,
    this.actions,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 25.sp,
      leading: showBack
          ? InkWell(
            onTap: onBack ??() => Get.back(),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft01,
              color: AppColors.textLight,
            ),
          )
          : SizedBox.shrink(),
      title: Text(
        title,
        style: AppTypography.subtitle(color: AppColors.textLight),
      ),
      centerTitle: centerTitle,
      actions: actions,
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
