import 'package:flutter/material.dart';
import '../../../../core/components/app_monthGridView.dart';
import '../../../../core/components/app_sectionHeader.dart';
import '../../../data/models/attendance_model.dart';
import '../leave_controller.dart';

class LeaveMonthGrid extends StatelessWidget {
  final LeaveController controller;
  const LeaveMonthGrid({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MonthGridViewComponent là component grid mà bạn đã chuẩn bị,
    // nó nhận callback getStatus & onDaySelected.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SectionHeader(title: "Chọn ngày muốn nghỉ",actionText: "Tháng",),
          SizedBox(height: 20,),
          Expanded(
            child: MonthGridViewComponent(
              initialSelectedDay: DateTime.now(),
              events: {
                "2025-09-10": AttendanceStatus.full,
                "2025-09-15": AttendanceStatus.missing,
                "2025-09-22": AttendanceStatus.lateOrEarly,
              },
              onDaySelected: (day) {
                // Khi user chọn ngày ở grid -> sử dụng LeaveController để chuyển view
                controller.selectDay(day.day);
              },
            ),
          ),
        ],
      ),
    );
  }
}
