import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/button/circle_icon_button.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/linear_progress.dart';
import '../widgets/transaction_card.dart';

class DebtHistoryPage extends StatelessWidget {
  const DebtHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text("Tổng Quan",style: AppTypography.subtitle(color: AppColors.primary),),
                Divider(color: AppColors.backgroundInput,),
                buildBalanceItem("Tổng nợ","1.000.0000 VNĐ"),
                buildBalanceItem("Đã thanh toán","500.000 VNĐ"),
                buildBalanceItem("Còn lại","500.000 VNĐ"),
                SizedBox(height: 5,),
                CustomLinearProgress(
                  value: 0.5,
                ),
                Divider(color: AppColors.backgroundInput,),
              ],
            ),
          ),
        ),
         SliverPersistentHeader(
          pinned: true,
          delegate: _HeaderDelegate(
            title: "Danh Sách Giao Dịch",
            onActionTap: () {
              print("object");
              showModalBottomSheet(
                backgroundColor: AppColors.background,
                context: context,
                builder: (_) => Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Lọc Danh Sách', style: AppTypography.subtitle()),
                      SizedBox(height: 20,),
                      
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButtonComponent(onPressed: () {}, title: "Hủy",color: AppColors.background,),
                          TextButtonComponent(onPressed: () {}, title: "Áp dụng",),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SliverList.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return TransactionCard(
              date: "15/09/2025",
              title: "Tạm Ứng Lương",
              amount: "5,000,000đ",
              status: "Đã duyệt",
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
  final String? actionText;
  final VoidCallback onActionTap;

  _HeaderDelegate({
    required this.title,
    required this.onActionTap,
    this.actionText,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundInput,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: TextEditingController(),
            style: AppTypography.button(color: AppColors.primary),
            decoration: InputDecoration(
              hintText: "Tìm kiếm...",
              hintStyle: AppTypography.body(color: AppColors.primary),
              filled: true,
              fillColor: AppColors.background,
              prefixIcon: Icon(Icons.search, color: AppColors.primary),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.background, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.background, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.background, width: 3),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: AppTypography.subtitle()),
              actionText != null 
                ? GestureDetector(
                  onTap: onActionTap,
                  child: Text(actionText!, style: AppTypography.smallbody(color: AppColors.primary,decoration: TextDecoration.underline)))
                : CircleIconButton(
                  icon: HugeIcons.strokeRoundedFilter,
                  backgroundColor: AppColors.primary,
                  iconColor: AppColors.background,
                  sizeCircle: 30,
                  onPressed: onActionTap,
                ),
              
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 110;

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