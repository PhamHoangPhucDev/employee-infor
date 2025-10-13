import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SectionHeaderComponent extends StatelessWidget {
  final String title;
  final Widget? trading;
  final VoidCallback? onActionPressed;
  final Color color;

  SectionHeaderComponent({
    Key? key,
    required this.title,
    this.trading,
    this.onActionPressed,
    this.color = AppColors.primary
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
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
                child: trading??SizedBox.shrink(),
              ),
            ],
          ),
          Divider(
            color: AppColors.backgroundInput,
            height: 5,
          ),
        ],
      ),
    );
  }
}
