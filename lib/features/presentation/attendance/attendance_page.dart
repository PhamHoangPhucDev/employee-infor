import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/components/month_gridView_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'attendance_controller.dart';

class AttendancePage extends StatelessWidget {
  AttendancePage({super.key});
  final controller = Get.put(AttendanceController());

  final List<String> options = ['Ngày', 'Tháng', 'Năm'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.attendanceTitle),
      body: CustomScrollView(
        slivers: [
          /// Header Avatar + Giờ làm việc
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 13.h,
                  width: 100.w,
                  color: AppColors.primary,
                  child: Center(
                    child: SizedBox(
                      width: 70.w,
                      height: 15.h,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.background,
                          child: const Icon(Icons.person),
                        ),
                        title: Text("Nguyễn Văn A",
                            style: AppTypography.body(color: AppColors.textLight)),
                        subtitle: Text("Nhân viên",
                            style: AppTypography.smallbody(color: AppColors.textLight)),
                      ),
                    ),
                  ),
                ),
                // Khung giờ làm việc (dính ngay dưới avatar)
                Transform.translate(
                  offset: Offset(0, -20), // dịch lên trên 20px
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border.all(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HugeIcon(icon: HugeIcons.strokeRoundedAlarmClock, color: AppColors.primary, size: 18.sp),
                        const SizedBox(width: 5),
                        Text("Mon-Sat / 9:00AM - 5:00PM", style: AppTypography.body()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Hồ sơ
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hồ sơ",
                      style: AppTypography.body(color: AppColors.primary)),
                  Text(
                    "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch.",
                    style: AppTypography.smallbody(),
                  ),
                ],
              ),
            ),
          ),

          /// Dropdown chọn ngày / tháng / năm
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Row(
          //       children: [
          //         Text("Chọn ngày",style: AppTypography.body(color: AppColors.primary)),
          //         const SizedBox(width: 12),
          //         Expanded(
          //           child: Obx(
          //             () => Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 GestureDetector(
          //                   onTap: () => controller.selectMonth(false),
          //                   child: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
          //                 ),
          //                 Text(
          //                   DateFormat('MM/yyyy').format(controller.currentMonth.value),
          //                   style: AppTypography.body(),
          //                 ),
          //                 GestureDetector(
          //                   onTap: () => controller.selectMonth(true),
          //                   child: HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          SliverToBoxAdapter(
            child: Divider(
              color: AppColors.backgroundInput, indent: 10, endIndent: 10
            ),
          ),

          /// Calendar + legend + detail
          SliverToBoxAdapter(
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    MonthGridViewComponent(
                      initialSelectedDay: controller.currentMonth.value,
                      getStatus: (day) => controller.getDayStatus(day),
                      onDaySelected: (day) => controller.toggleSelectedDay(day),
                      month: controller.currentMonth.value,
                      title: "Chọn ngày",
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      final visible = controller.showDetail.value;
                      final detail = controller.getDayDetail(controller.selectedDay.value);
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: visible
                            ? Container(
                                key: ValueKey(detail),
                                width: 100.w,
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundInput,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(detail, style: AppTypography.smallbody()),
                              )
                            : const SizedBox.shrink(),
                      );
                    }),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
