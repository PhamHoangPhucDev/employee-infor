import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/app_circleIconButton.dart';
import '../../../core/components/app_horizontalCalendar.dart';
import '../../../core/components/app_sectionHeader.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../domain/services/auth_service.dart';
import '../auth/auth_controller.dart';
import '../leave/leave_page.dart';
import 'widgets/iconButton_item.dart';

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
        // appBar: AppBar(
        //   backgroundColor: AppColors.background,
        //   title: Obx(() => Text('Xin chào, ${authService.user?.name ?? 'Bạn'}')),
      
        //   actions: [
        //     // IconButton(
        //     //   icon: const Icon(Icons.person),
        //     //   onPressed: () => Get.toNamed(AppRoutes.profile),
        //     // ),
        //     // IconButton(
        //     //   icon: const Icon(Icons.logout),
        //     //   onPressed: () => Get.find<AuthController>().logout(),
        //     // ),
      
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Header (iconbutton + avata)
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Icon
                    Row(
                      children: [
                        AppCircleIconButton(
                          icon: HugeIcons.strokeRoundedNotification01,
                          onPressed: () {
                            print("Chuông thông báo");
                          },
                        ),
                        SizedBox(width: 5,),
                        AppCircleIconButton(
                          icon: HugeIcons.strokeRoundedSettings01,
                          onPressed: () {
                            print("Cài đặt");
                          },
                        ),
                        SizedBox(width: 5,),
                        AppCircleIconButton(
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
              SizedBox(height: 10,),

              //Danh sách chức năng
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SectionHeader(title: "Danh sách chức năng",),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconTextButton(
                          icon: HugeIcons.strokeRoundedFingerPrintCheck,
                          label: "Chấm Công",
                          onPressed: () => Get.toNamed(AppRoutes.attendance),
                        ),
                        IconTextButton(
                          icon: HugeIcons.strokeRoundedUserList,
                          label: "D.s Nhân Viên",
                          onPressed: () => Get.toNamed(AppRoutes.employees),
                        ),
                        IconTextButton(
                          icon: HugeIcons.strokeRoundedBitcoinCreditCard,
                          label: "Công nợ",
                          onPressed: () => print("Công nợ"),
                        ),
                        IconTextButton(
                          icon: HugeIcons.strokeRoundedQuestion,
                          label: "Hỗ Trợ",
                          onPressed: () => print("Hỗ Trợ"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          
              // Lịch trình
              Container(
                color: AppColors.primary,
                width: 100.w,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                      child: SectionHeader(title: "Lịch trình sắp tới",actionText: "Tháng",color: AppColors.textLight,),
                    ),
                    SizedBox(height: 10,),
                    // Lịch ngang
                    AppHorizontalCalendar(),
          
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
              SizedBox(height: 10,),
              // Chế độ
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SectionHeader(title: "Chế độ"),
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
                                  Text('Nghỉ phép',style: AppTypography.button(color: AppColors.textLight),)
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
                                  print("Lương");
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
                                  print("Chế độ");
                                },
                                icon: HugeIcon(icon: HugeIcons.strokeRoundedSaveMoneyDollar,color: AppColors.textLight,size: 25.sp),
                                label: Text(
                                  "Chế độ",
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
            ],
          ),
        ),
      ),
    );
  }
}
