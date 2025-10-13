import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/listTile_icon_component.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/searchBar_header_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/balance_overview.dart';

class AdvanceSalaryPage extends StatelessWidget {
  const AdvanceSalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BalanceOverviewComponent(
            title: "Khoản dư",
            items: {
              "Tổng số lần tạm ứng tháng này": "2",
              "Số tiền còn lại có thể tạm ứng": "500.000 VNĐ",
            },
            showProgress: false,
          ),
        ),
        // title header
        SearchBarHeaderComponent(
          showSearchInput: false,
          backgroundColor: AppColors.backgroundInput,
          title: "Lịch Sử Tạm Ứng",
          actionText: "Xem Tất Cả",
          onActionTap: () {},
        ),
        // Danh sách tạm ứng
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
                height: 25,
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