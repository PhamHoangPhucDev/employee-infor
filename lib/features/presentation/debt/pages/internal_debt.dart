import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/listTile_icon_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class InternalDebtPage extends StatelessWidget {
  const InternalDebtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        // Filter
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text("Sắp xếp theo", style: AppTypography.smallbody()),
                const SizedBox(width: 5),
                TextButtonComponent(
                  title: "A->Z",
                  height: 25,
                ),
                const SizedBox(width: 5),
                TextButtonComponent(
                  title: "Bảo hiểm",
                  height: 25,
                  color: AppColors.background,
                ),
                const SizedBox(width: 5),
                TextButtonComponent(
                  title: "Vay",
                  height: 25,
                  color: AppColors.background,
                ),
                const SizedBox(width: 5),
                TextButtonComponent(
                  title: "Khác",
                  height: 25,
                  color: AppColors.background,
                ),
              ],
            ),
          ),
        ),

        SliverList.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTileIconComponent(
              icon: HugeIcons.strokeRoundedSaveMoneyDollar,
              title: "Vay Nội Bộ",
              subtitle: "Tổng nợ: 1.000.000VNĐ - Đã trả: 500.000VNĐ\nHạn cuối: 30/12/2026",
              trailing: Row(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  VerticalDivider(thickness: 1,color: AppColors.backgroundInput,),
                  HugeIcon(icon: HugeIcons.strokeRoundedMasterCard,color: AppColors.primary,)
                ],
              ),
            );
          },
        )
      ],
    );
  }
}