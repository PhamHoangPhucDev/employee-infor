import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/app_dialog_component.dart.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/filter_button_row_component.dart';
import '../../../../core/components/searchBar_header_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/balance_overview.dart';
import '../widgets/transaction_card.dart';

class DebtHistoryPage extends StatelessWidget {
  const DebtHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BalanceOverviewComponent(
            title: "Tổng Quan",
            items: {
              "Tổng nợ": "1.000.000 VNĐ",
              "Đã thanh toán": "500.000 VNĐ",
              "Còn lại": "500.000 VNĐ",
            },
            progressValue: .5,
          ),
        ),
        SearchBarHeaderComponent(
          title: "Danh Sách Giao Dịch",
          backgroundColor: AppColors.backgroundInput,
          onActionTap:() {
            AppDialogComponent.show(
              context: context,
              title: "Lọc Danh Sách",
              type: DialogType.bottomSheet,
              showCancel: true,
              confirmText: "Áp dụng",
              cancelText: "Hủy",
              confirmColor: AppColors.primary,
              cancelColor: AppColors.background,
              fields: [
                labelFilterButton(
                  "Loại",
                  FilterButtonRowComponent(
                    filters: ["Tạm ứng","Nợ nội bộ","Bảo hiểm","Vay hỗ trợ","Khác"],
                    onChanged: (value){},
                  ),
                ),
                SizedBox(height: 10,),
                labelFilterButton(
                  "Trạng thái",
                  FilterButtonRowComponent(
                    filters: ["Tất cả","Đã thanh toán","Đang trả góp","Chưa thanh toán"],
                    onChanged: (value){},
                  ),
                ),
                SizedBox(height: 10,),
                labelFilterButton(
                  "Hình thức",
                  FilterButtonRowComponent(
                    filters: ["Tiền mặt","Chuyển khoản","Khấu trừ lương"],
                    onChanged: (value){},
                  ),
                ),
                SizedBox(height: 10,),
                labelFilterButton(
                  "Ngày",
                  Row(
                    children: [
                      TextButtonComponent(
                        title: "Từ ngày",
                        color: AppColors.background,
                        height: 25,
                      ),
                      TextButtonComponent(
                        title: "Đến ngày",
                        color: AppColors.background,
                        height: 25,
                      ),
                    ],
                  )
                ),
              ],
              onConfirm: () {
                // xử lý khi nhấn xác nhận
              },
            );
          },
        ),
        //D.s giao dịch
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

Widget labelFilterButton (String label, Widget widget) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style: AppTypography.body(color: AppColors.primary),),
      SizedBox(height: 5,),
      widget
    ],
  );
}