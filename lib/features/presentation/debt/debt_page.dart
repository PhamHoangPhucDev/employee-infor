import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/components/app_dialog_component.dart.dart';
import '../../../core/components/text_field_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../helpcenter/widgets/outline_tabBar.dart';
import '../helpcenter/widgets/sliver_appBar_delegate.dart';
import 'pages/advance_salary.dart';
import 'pages/debt_history.dart';
import 'pages/internal_debt.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({super.key});

  @override
  State<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> with TickerProviderStateMixin {
  late TabController mainTabController;
  List<String> listTab = ["Ứng Lương","Nợ Nội Bộ","Lịch Sử"];

  @override
  void initState() {
    super.initState();
    mainTabController = TabController(length: listTab.length, vsync: this);
  }

  @override
  void dispose() {
    mainTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.debtTitle,),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            //TabBarView
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                child:  
                PreferredSize(
                  preferredSize: Size.fromHeight(5.h),
                  child: OutlineTabBar(
                    controller: mainTabController,
                    tabs: listTab,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  ),
                ),
              ),
            ),
            
          ],
          body: TabBarView(
            controller: mainTabController,
            physics: NeverScrollableScrollPhysics(),// không cho vuốt ngang
            children: [
              AdvanceSalaryPage(),
              InternalDebtPage(),
              DebtHistoryPage(),
            ],
          ),
        ),
       floatingActionButton: AnimatedBuilder(
        animation: mainTabController,
        builder: (context, _) {
          // Chỉ hiện FAB khi đang ở tab đầu tiên (Ứng lương)
          if (mainTabController.index == 0) {
            return FloatingActionButton(
              onPressed: () {
                AppDialogComponent.show(
                  context: context,
                  title: "Tạm Ứng Lương",
                  type: DialogType.bottomSheet,
                  confirmText: "Gửi yêu cầu",
                  confirmColor: AppColors.primary,
                  fields: [
                    TextFieldComponent(label: "Số tiền cần tạm ứng", controller: TextEditingController()),
                    TextFieldComponent(label: "Lý do", controller: TextEditingController()),
                    TextFieldComponent(label: "Ngày nhận", hintText: "Ngày nhận mong muốn", controller: TextEditingController()),
                  ],
                  onConfirm: () {
                    // xử lý khi nhấn xác nhận
                  },
                );
              },
              backgroundColor: AppColors.background,
              shape: CircleBorder(
                side: BorderSide(color: AppColors.primary, width: 1),
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedAdd01,
                size: 25.sp,
                color: AppColors.primary,
              ),
            );
          }
          // Các tab khác không hiển thị gì
          return const SizedBox.shrink();
        },
      ),
    );
  }
}