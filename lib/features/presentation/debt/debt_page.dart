import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/components/text_field_component.dart';
import '../../../core/components/button/text_button_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
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
                  preferredSize: Size.fromHeight(50),
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
                showModalBottomSheet(
                  backgroundColor: AppColors.background,
                  context: context,
                  builder: (_) => Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tạm Ứng Lương', style: AppTypography.subtitle()),
                        SizedBox(height: 20,),
                        TextFieldComponent(
                          controller: TextEditingController(),
                          label: "Số tiền cần tạm ứng",
                        ),
                        TextFieldComponent(
                          controller: TextEditingController(),
                          label: "Lý do",
                        ),
                        TextFieldComponent(
                          controller: TextEditingController(),
                          label: "Ngày nhận",
                          hintText: "Ngày nhận mong muốn",
                        ),
                        SizedBox(height: 5.h),
                        TextButtonComponent(onPressed: () {}, title: "Gửi yêu cầu",),
                      ],
                    ),
                  ),
                );
              },
              backgroundColor: AppColors.background,
              shape: CircleBorder(
                side: BorderSide(color: AppColors.primary, width: 1),
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedAdd01,
                size: 30,
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