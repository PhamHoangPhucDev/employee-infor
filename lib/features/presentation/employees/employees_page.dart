import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/components/listTile_icon_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/banner_header_component.dart';
import 'widgets/category_list_item.dart';
import 'pages/info_employee_page.dart';
import 'employees_controller.dart';
import '../../../core/components/searchBar_header_component.dart';

class EmployeesPage extends StatelessWidget {
  EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeesController());

    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.employeesTitle),
      body: CustomScrollView(
        slivers: [
          /// Banner ẩn dần
          BannerHeaderComponent(text: "Quản Lý Và Theo Dõi Danh Sách Nhân Viên Dễ Dàng Ngay Tại Đây."),

          /// Search
          SearchBarHeaderComponent(),

          /// Category list
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                CategoryListItem(
                  icons: [
                    HugeIcons.strokeRoundedUserGroup,
                    HugeIcons.strokeRoundedCalculate,
                    HugeIcons.strokeRoundedDeveloper,
                    HugeIcons.strokeRoundedMentor,
                    HugeIcons.strokeRoundedShopify,
                    HugeIcons.strokeRoundedUserList,
                    HugeIcons.strokeRoundedFactory,
                    HugeIcons.strokeRoundedManager,
                  ],
                  onItemSelected: (index) {
                    print("Bạn chọn item: $index");
                  },
                ),
                Divider(
                  color: AppColors.backgroundInput,
                  height: 10,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          ),

          /// Filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text("Sắp xếp theo", style: AppTypography.smallbody()),
                  const SizedBox(width: 5),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(50, 25),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      print("A->Z");
                    },
                    child: Text("A->Z",
                        style: AppTypography.button(color: AppColors.textLight)),
                  ),
                  const SizedBox(width: 5),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.background,
                      minimumSize: const Size(50, 25),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                    ),
                    onPressed: () {
                      print("Hiện filter");
                    },
                    child: Text("Filter",
                        style: AppTypography.button(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Divider(
              color: AppColors.backgroundInput,
              height: 10,
              indent: 20,
              endIndent: 20,
            ),
          ),

          /// Danh sách nhân viên
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTileIconComponent(
                icon: HugeIcons.strokeRoundedUserCircle,
                title: "Nguyễn Văn A$index",
                subtitle: "Nhân viên $index",
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.background,
                    minimumSize: const Size(50, 25),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: AppColors.primary, width: 1.5),
                    ),
                  ),
                  onPressed: () {
                    print("Chuyển page Info Nguyễn Văn A$index");
                    Get.to(() => InfoEmployeePage());
                  },
                  child: Text("Info",
                      style: AppTypography.button(color: AppColors.primary)),
                ),
              ),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}