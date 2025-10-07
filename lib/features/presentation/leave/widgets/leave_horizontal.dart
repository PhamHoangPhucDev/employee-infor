import 'package:flutter/material.dart';
import '../../../../core/components/horizontal_calendar_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../data/models/attendance_model.dart';
import '../leave_controller.dart';
import 'leave_form.dart';

class LeaveHorizontal extends StatelessWidget {
  final LeaveController controller;
  const LeaveHorizontal({Key? key, required this.controller}) : super(key: key);

  int getDaysInMonth(DateTime date) {
    final firstDayThisMonth = DateTime(date.year, date.month, 1);
    final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 90,
          child: HorizontalCalendarComponent(
            events: {
              "2025-09-10": AttendanceStatus.full,
              "2025-09-15": AttendanceStatus.missing,
              "2025-09-22": AttendanceStatus.lateOrEarly,
            },
            isSelectedDay: controller.selectedDay.value,
            iconColor: AppColors.primary,
          ),
        ),
        Expanded(child: LeaveForm(controller: controller)),
      ],
    );
  }
}
