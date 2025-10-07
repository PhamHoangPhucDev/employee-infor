import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TransactionCard extends StatelessWidget {
  final String date;
  final String title;
  final String? description;
  final String amount;
  final String status;
  final Color statusColor;

  const TransactionCard({
    super.key,
    required this.date,
    required this.title,
    this.description,
    required this.amount,
    required this.status,
    this.statusColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: statusColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.disabled.withValues(alpha: .1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          HugeIcon(icon: HugeIcons.strokeRoundedRadioButton,color: AppColors.primary,),
          SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dòng tiêu đề
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "$date - $title",
                        style: AppTypography.body(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (description != null)
                  Text(
                    description!,
                    style: AppTypography.smallbody(),
                  ),
                Text("Số tiền: $amount",
                    style: AppTypography.smallbody()),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "Trạng Thái: ",
                      style: AppTypography.smallbody(),
                    ),
                    TextButtonComponent(
                      title: status,
                      color: statusColor,
                      height: 25,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
