import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionPressed;
  final Color color;

  const SectionHeader({
    Key? key,
    required this.title,
    this.actionText = "Xem tất cả",
    this.onActionPressed,
    this.color = AppColors.primary
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.body(color: color),
            ),
            GestureDetector(
              onTap: onActionPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    actionText,
                    style: AppTypography.smallbody(
                      color: color,
                      decoration: TextDecoration.underline, // gạch chân
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: AppColors.backgroundInput,
          height: 5,
        ),
      ],
    );
  }
}
