import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBack;
  final List<Widget>? actions;

  const AppBarComponent({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.showBack = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined,color: AppColors.textLight),
              onPressed: () => Get.back(),
            )
          : null,
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
