import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
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

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            //Header (iconbutton + avata)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Icon
                    Row(
                      children: [
                        CircleIconButton(
                          icon: HugeIcons.strokeRoundedNotification01,
                          onPressed: () {
                            Get.toNamed(AppRoutes.notification);
                          },
                        ),
                        SizedBox(width: 5,),
                        CircleIconButton(
                          icon: HugeIcons.strokeRoundedSettings01,
                          onPressed: () {
                            print("Cài đặt");
                            Get.toNamed(AppRoutes.profile);
                          },
                        ),
                        SizedBox(width: 5,),
                        CircleIconButton(
                          icon: HugeIcons.strokeRoundedSearch02,
                          onPressed: () {
                            print("Tìm kiếm");
                          },
                        ),
                      ],
                    ),
                        
                    //Avatar + name
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Xin chào",
                              style: AppTypography.smallbody(color: AppColors.primary),
                            ),
                            Text(
                              authService.user?.name ?? 'Bạn',
                              style: AppTypography.body(),
                            ),
                          ],
                        ),
                        SizedBox(width: 8,),
                        CircleAvatar()
                      ],
                    )
                  ],
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                      child: SectionHeaderComponent(title: "Lịch trình sắp tới",actionText: "Tháng",color: AppColors.textLight,),
                    ),
                    SizedBox(height: 10,),
                    // Lịch ngang
                    HorizontalCalendarComponent(),
                      
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
                        child: Padding(
                          padding: EdgeInsets.all(16),
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
                          child: InkWell(
                            child: Container(
                              height: 16.h + 8,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                border: Border.all(
                                  color: AppColors.border, // màu border
                                  width: 2,           // độ dày border
                                ),
                                borderRadius: BorderRadius.circular(18), // bo góc
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HugeIcon(icon: HugeIcons.strokeRoundedCalendar03,color: AppColors.textLight,size: 25.sp),
                                  Text('Nghỉ Phép',style: AppTypography.button(color: AppColors.textLight),)
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.to(() => LeavePage());
                            },
                          ),
                        ),
                      
                        const SizedBox(width: 8),
                      
                        Column(
                          children: [
                            //Lương
                            Container(
                              width: 40.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                border: Border.all(
                                  color: AppColors.border, // màu border
                                  width: 2,           // độ dày border
                                ),
                                borderRadius: BorderRadius.circular(18), // bo góc
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.salary);
                                },
                                icon: HugeIcon(icon: HugeIcons.strokeRoundedMoney03,color: AppColors.textLight,size: 25.sp),
                                label: Text(
                                  "Lương",
                                  style: AppTypography.button(color: AppColors.textLight),
                                ),
                              )
                            ),
                            const SizedBox(height: 8),
                            //Phúc lợi
                            Container(
                              width: 40.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                border: Border.all(
                                  color: AppColors.border, // màu border
                                  width: 2,           // độ dày border
                                ),
                                borderRadius: BorderRadius.circular(18), // bo góc
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.employeebenefits);
                                },
                                icon: HugeIcon(icon: HugeIcons.strokeRoundedSaveMoneyDollar,color: AppColors.textLight,size: 25.sp),
                                label: Text(
                                  "Phúc Lợi",
                                  style: AppTypography.button(color: AppColors.textLight),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )   
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
