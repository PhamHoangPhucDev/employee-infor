import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/button/confirm_bottom_sheet.dart';
import '../../../core/components/fancy_icon.dart';
import '../../../core/components/horizontal_calendar_component.dart';
import '../../../core/components/button/circle_icon_button.dart';
import '../../../core/components/section_header_component.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../data/models/functionItem_model.dart';
import '../../domain/services/auth_service.dart';
import '../auth/auth_controller.dart';
import '../leave/leave_page.dart';
import 'widgets/icon_text_button.dart';

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

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(child: FlutterLogo(),backgroundColor: AppColors.background,),
                          SizedBox(width: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Xin chào",
                                style: AppTypography.smallbody(color: AppColors.background),
                              ),
                              Text(
                                authService.user?.name ?? 'Bạn',
                                style: AppTypography.body(color: AppColors.background),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                      CircleIconButton(
                        icon: HugeIcons.strokeRoundedLogout02,
                        iconSize: 20,
                        sizeCircle: 30,
                        onPressed: ()=>showConfirmBottomSheet(
                          title: "",
                          message: "Bạn có chắc chắn muốn đăng xuất không?",
                          confirmText: "Xác nhận",
                          onConfirm: () {
                            // controller.logout();
                            print("Đăng xuất thành công");
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        
            //Danh sách chức năng
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeaderComponent(title: "Danh sách chức năng"),
                    // List ngang
                    SizedBox(
                      height: 10.h, // Chiều cao của item
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: functionItems.length,
                        itemBuilder: (context, index) {
                          final item = functionItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 20.w,
                              child: IconTextButton(
                                icon: item.icon,
                                label: item.label,
                                onPressed: item.onPressed,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
                              Divider(color: AppColors.backgroundInput,height: 10,),
                              // item
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• 11 Month - Wednesday - Today",
                                    style: AppTypography.smallbody(color: AppColors.textLight),
                                  ),
                                  Row(
                                    children: [
                                      HugeIcon(icon: HugeIcons.strokeRoundedAlarmClock,color: AppColors.textLight,size: 16.sp),
                                      SizedBox(width: 1),
                                      Text("10:00 am", style: AppTypography.body(color :AppColors.textLight)),
                                      Spacer(),
                                      Text("Dr. Olivia Turner", style: AppTypography.body(color :AppColors.textLight)),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(color: AppColors.backgroundInput,height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• 11 Month - Wednesday - Today",
                                    style: AppTypography.smallbody(color: AppColors.textLight),
                                  ),
                                  Row(
                                    children: [
                                      HugeIcon(icon: HugeIcons.strokeRoundedAlarmClock,color: AppColors.textLight,size: 16.sp),
                                      SizedBox(width: 1),
                                      Text("10:00 am", style: AppTypography.body(color :AppColors.textLight)),
                                      Spacer(),
                                      Text("Dr. Olivia Turner", style: AppTypography.body(color :AppColors.textLight)),
                                    ],
                                  ),
                                ],
                              ),
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
                    SizedBox(height: 10.h,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
