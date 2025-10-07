import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/listTile_icon_component.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AdvanceSalaryPage extends StatelessWidget {
  const AdvanceSalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text("Khoản Dư",style: AppTypography.subtitle(color: AppColors.primary),),
                Divider(color: AppColors.backgroundInput,),
                buildBalanceItem("Tổng số lần tạm ứng tháng này","2"),
                buildBalanceItem("Số tiền còn lại có thể tạm ứng","10.000.000 VNĐ"),
                Divider(color: AppColors.backgroundInput,),
              ],
            ),
          ),
        ),
         SliverPersistentHeader(
          pinned: true,
          delegate: _HeaderDelegate(
            title: "Lịch Sử Tạm Ứng",
            actionText: "Xem Tất Cả",
            onActionTap: () {},
          ),
        ),
        SliverList.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTileIconComponent(
              icon: HugeIcons.strokeRoundedCalendar03,
              title: "100.000 VNĐ",
              subtitle: "19/10/2025",
              trailing: TextButtonComponent(
                title: "Chờ duyệt",
                color: AppColors.background,
                height: 30,
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 10.h,),
        )
      ],
    );
  }
}

/// Header delegate tuỳ chỉnh cho SliverPersistentHeader
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final String actionText;
  final VoidCallback onActionTap;

  _HeaderDelegate({
    required this.title,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundInput,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: AppTypography.subtitle()),
          GestureDetector(
            onTap: onActionTap,
            child: Text(actionText,
                style: AppTypography.smallbody(color: AppColors.primary,decoration: TextDecoration.underline)),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) => false;
}

Widget buildBalanceItem(String title, String? value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('$title: ',style: AppTypography.smallbody()),
      Text('$value',style: AppTypography.body(color: AppColors.primary))
    ]
  );
}