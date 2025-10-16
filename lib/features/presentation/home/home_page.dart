import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/fancy_icon.dart';
import '../../../core/components/horizontal_calendar_component.dart';
import '../../../core/components/section_header_component.dart';
import '../../../core/constants/app_padding_bottom.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../data/models/functionItem_model.dart';
import '../../domain/services/auth_service.dart';
import '../leave/leave_page.dart';
import 'widgets/animated_func_header_delegate.dart';
import 'widgets/function_header_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
        // Phần chào người dùng
          SliverPersistentHeader(
            pinned: true,
            delegate: AnimatedFunctionHeaderDelegate(),
          ),
          
          //Danh sách chức năng
          SliverPersistentHeader(
            pinned: true,
            delegate: FunctionHeaderDelegate(
              functionItems: functionItems, // danh sách icon
            ),
          ),
        
          // Lịch trình
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.primary,
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  // Lịch ngang
                  HorizontalCalendarComponent(
                    title: "Lịch trình sắp tới",
                  ), 
                  SizedBox(height: 16),
                  // Chi tiết lịch hôm đó
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Card(
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(color: AppColors.border, width: 1),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.background.withValues(alpha: 0.1),
                              AppColors.background.withValues(alpha: 0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.background.withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.background.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Chi tiết ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                style: AppTypography.body(color: AppColors.textLight)),
                            //1 - 10 item List.generate/ >20 ListView.builder
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(3, (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(color: AppColors.backgroundInput, height: 10),
                                    Text(
                                      "• 11 Month - Wednesday - Today",
                                      style: AppTypography.smallbody(color: AppColors.textLight),
                                    ),
                                    Row(
                                      children: [
                                        HugeIcon(icon: HugeIcons.strokeRoundedAlarmClock, color: AppColors.textLight, size: 16.sp),
                                        SizedBox(width: 1),
                                        Text("10:00 am", style: AppTypography.body(color: AppColors.textLight)),
                                        Spacer(),
                                        Text("Dr. Olivia Turner", style: AppTypography.body(color: AppColors.textLight)),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          
          // Chế độ
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                children: [
                  SectionHeaderComponent(title: "Chế độ"),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      // Nghỉ phép
                      Expanded(
                        child: FeatureCardBase(
                          height: 16.h + 8,
                          backgroundIcon: Icons.calendar_month,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HugeIcon(icon: HugeIcons.strokeRoundedCalendar03, color: AppColors.primary, size: 25.sp),
                              SizedBox(height: 12),
                              Text('Nghỉ Phép',style: AppTypography.button(color: AppColors.primary),)
                            ],
                          ),
                          onTap: ()=>  Get.to(() => LeavePage()),
                        )
                      ),
                    
                      const SizedBox(width: 8),
                    
                      Column(
                        children: [
                          //Lương
                          FeatureCardBase(
                            height: 8.h,
                            width: 40.w,
                            sizeIcon: 70,
                            backgroundIcon: Icons.money_rounded,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HugeIcon(icon: HugeIcons.strokeRoundedMoney03,color: AppColors.primary,size: 25.sp),
                                Text(
                                  "Lương",
                                  style: AppTypography.button(color: AppColors.primary),
                                ),
                              ],
                            ),
                            onTap: ()=> Get.toNamed(AppRoutes.salary),
                          ),
                          const SizedBox(height: 8),
                          //Phúc lợi
                          FeatureCardBase(
                            height: 8.h,
                            width: 40.w,
                            sizeIcon: 70,
                            backgroundIcon: Icons.monetization_on_outlined,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HugeIcon(icon: HugeIcons.strokeRoundedSaveMoneyDollar,color: AppColors.primary,size: 25.sp),
                                Text(
                                  "Phúc Lợi",
                                  style: AppTypography.button(color: AppColors.primary),
                                ),
                              ],
                            ),
                            onTap: ()=> Get.toNamed(AppRoutes.employeebenefits),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppPaddingBottom.getBottomPadding(context),
            ),
          ),
        ],
      ),
    );
  }
}

