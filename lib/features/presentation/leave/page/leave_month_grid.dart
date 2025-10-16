import 'package:flutter/material.dart';
import '../../../../core/components/month_gridView_component.dart';
import '../../../../core/components/section_header_component.dart';
import '../../../data/models/attendance_model.dart';
import '../leave_controller.dart';

class LeaveMonthGrid extends StatelessWidget {
  final LeaveController controller;
  const LeaveMonthGrid({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MonthGridViewComponent nhận callback getStatus & onDaySelected.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MonthGridViewComponent(
              events: {
                "2025-10-10": AttendanceStatus.full,
                "2025-10-15": AttendanceStatus.missing,
                "2025-10-22": AttendanceStatus.lateOrEarly,
              },
              month: DateTime.now(),
              title: "Chọn ngày muốn nghỉ",
              notesDot: ["Đã duyệt","Đang duyệt","Từ chối"],
              onDaySelected: (day) {
                // Khi user chọn ngày ở grid -> sử dụng LeaveController để chuyển view
                controller.selectDay(day);
              },
            ),
          ),
        ],
      ),
    );
  }
}
