import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/app_appBar.dart';
import '../../../core/components/app_monthGridView.dart';
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar header
              Container(
                height: 15.h,
                width: 100.w,
                color: AppColors.primary,
                child: Center(
                  child: SizedBox(
                    width: 70.w, height: 15.h,
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

              // Hồ sơ 
              Padding( 
                padding: EdgeInsets.only(left: 20.0,top: 5.h), 
                child: Text("Hồ sơ",
                  style: AppTypography.body(color: AppColors.primary),
                ), 
              ), 
              Padding( 
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20,vertical: 5), 
                child: Text( "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch.", 
                  style: AppTypography.smallbody(), 
                ), 
              ),
              Divider(color: AppColors.backgroundInput, indent: 10, endIndent: 10),
          
              // Dropdown chọn ngày / tháng / năm 
              Padding( 
                padding: EdgeInsets.only(left: 10.0), 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: [
                    Text("Chọn ngày", style: AppTypography.body(color: AppColors.primary)),
                    Obx( () => DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedValue.value, 
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary), 
                        iconSize: 25.sp, 
                        elevation: 16, 
                        style: AppTypography.body(),
                        isDense: true, // làm dropdown nhỏ gọn
                        underline: const SizedBox(), // bỏ gạch dưới 
                        onChanged: (String? newValue) { 
                          if (newValue != null) { 
                            controller.selectedValue.value = newValue; 
                          } 
                        }, 
                        items: options.map<DropdownMenuItem<String>>((String value) { 
                          return DropdownMenuItem<String>( 
                            value: value, 
                            child: Text(value), 
                          ); 
                        }).toList(), 
                      ),
                    ),),
                  ], 
                ), ),

              Divider(color: AppColors.backgroundInput, indent: 10, endIndent: 10),
          
              // Calendar
              Expanded(
                child: Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        //Lịch tháng hiện tại
                        Expanded(
                          child: MonthGridViewComponent(
                            initialSelectedDay: controller.currentMonth.value,
                            getStatus: (day) {
                              // lấy trạng thái từ controller
                              return controller.getDayStatus(day);
                            },
                            onDaySelected: (day) {
                              controller.toggleSelectedDay(day);
                            },
                          ),
                        ),
                          
                        const SizedBox(height: 8),
                        // legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _legendItem(AppColors.success, "Đủ giờ"),
                            _legendItem(AppColors.warning, "Trễ/Sớm"),
                            _legendItem(AppColors.error, "Thiếu"),
                            // _legendItem(Colors.transparent, "Chưa chấm"),
                          ],
                        ),
                          
                        const SizedBox(height: 8),
                        // detail selectedDay with animation
                        Obx(() {
                          final visible = controller.showDetail.value;
                          final detail = controller.getDayDetail(controller.selectedDay.value);
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.2),
                                  end: Offset.zero,
                                ).animate(anim),
                                child: FadeTransition(opacity: anim, child: child),
                              );
                            },
                            child: visible
                                ? Container(
                                    key: ValueKey(detail),
                                    width: 100.w,
                                    margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
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

          //Kinh nghiệm & thời gian đi làm 
          Positioned(
            top: 12.5.h,
            child: SizedBox( 
              width: 100.w, 
              child: Center( 
                child: Container( 
                  height: 5.h, 
                  padding: EdgeInsets.symmetric(horizontal: 30), 
                  decoration: BoxDecoration( 
                    color: AppColors.background, // nền 
                    border: Border.all(
                      color: AppColors.primary, // màu border 
                      width: 2, 
                    ), 
                    borderRadius: BorderRadius.circular(12), 
                  ), 
                  child: Row( 
                    mainAxisSize: MainAxisSize.min, // chỉ vừa với nội dung
                    children: [ 
                      HugeIcon(icon: HugeIcons.strokeRoundedAlarmClock,color: AppColors.primary,size: 18.sp),
                      SizedBox(width: 5,),
                      Text( "Mon-Sat / 9:00AM - 5:00PM", style: AppTypography.body(), ), 
                    ], 
                  ), 
                ), 
              ), 
            ), 
          ) 
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        if (color != Colors.transparent) Container(
          width: 13.sp,
          height: 13.sp,
          decoration: BoxDecoration(
            color: color,  // màu: red / yellow / green
            shape: BoxShape.circle,
          ),
        ),

        if (color == Colors.transparent) SizedBox(width: 16, height: 16),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
