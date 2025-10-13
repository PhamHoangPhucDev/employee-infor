import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'linear_progress.dart';

class BalanceOverviewComponent extends StatelessWidget {
  final String title;
  final Map<String, String> items;
  final double progressValue;
  final bool showProgress; // hiển thị thanh tiến độ
  final bool showBottomDivider; // hiển thị divider cuối
  final EdgeInsetsGeometry? padding; // tuỳ chỉnh padding

  const BalanceOverviewComponent({
    super.key,
    this.title = "Tổng Quan",
    required this.items,
    this.progressValue = 0.0,
    this.showProgress = true,
    this.showBottomDivider = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 1.h),
      child: Column(
        children: [
          Text(
            title,
            style: AppTypography.subtitle(color: AppColors.primary),
          ),
          Divider(color: AppColors.backgroundInput),

          // Danh sách dòng dữ liệu
          ...items.entries.map((e) => _buildBalanceItem(e.key, e.value)),

          SizedBox(height: 1.h),

          // Hiển thị thanh tiến độ nếu cần
          if (showProgress) CustomLinearProgress(value: progressValue),

          // Divider cuối cùng
          if (showBottomDivider) Divider(color: AppColors.backgroundInput),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label: ',style: AppTypography.smallbody()),
          Text(value,style: AppTypography.body(color: AppColors.primary))
        ],
      ),
    );
  }
}
