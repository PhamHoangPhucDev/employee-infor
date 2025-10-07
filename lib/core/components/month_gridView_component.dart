import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../features/data/models/attendance_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Component hiển thị lịch tháng (Grid 7 cột)
class MonthGridViewComponent extends StatefulWidget {
  /// Map ngày -> status (key: yyyy-MM-dd)
  final Map<String, AttendanceStatus>? events;

  /// Hàm lấy status cho từng ngày
  final AttendanceStatus Function(DateTime day)? getStatus;

  /// Callback khi chọn ngày
  final void Function(DateTime day)? onDaySelected;

  /// Ngày đang được chọn (nếu có)
  final DateTime? initialSelectedDay;

  const MonthGridViewComponent({
    super.key,
    this.getStatus,
    this.onDaySelected,
    this.initialSelectedDay, 
    this.events,
  });

  @override
  State<MonthGridViewComponent> createState() => _MonthGridViewComponentState();
}

class _MonthGridViewComponentState extends State<MonthGridViewComponent> {
  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialSelectedDay ?? DateTime.now();
  }

  /// Lấy tất cả ngày trong 1 tháng
  List<DateTime> getDaysInMonth(DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(
      daysInMonth,
      (i) => DateTime(month.year, month.month, i + 1),
    );
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatKey(DateTime d) =>
      "${d.year.toString().padLeft(4, '0')}-"
      "${d.month.toString().padLeft(2, '0')}-"
      "${d.day.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    final days = getDaysInMonth(DateTime.now()); // tháng hiện tại

    return Column(
      children: [
        // header thứ trong tuần
        Row(
          children: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN']
              .map((dd) => Expanded(
                    child: CircleAvatar(
                      radius: 15.sp,
                      backgroundColor: AppColors.primary,
                      child: Center(
                        child: Text(
                          dd,
                          style: AppTypography.body(color: AppColors.textLight),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),

        // grid ngày trong tháng
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              final key = _formatKey(day);
              // Ưu tiên events, nếu không có thì gọi getStatus
              final status = widget.events?[key] ??
                  widget.getStatus?.call(day) ??
                  AttendanceStatus.empty;

              return _buildDayCell(
                isSameDay(selectedDay, day),
                day,
                status,
                (v) {
                  setState(() {
                    selectedDay = v;
                  });
                  widget.onDaySelected?.call(v);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// UI cho 1 ô ngày
  Widget _buildDayCell(
    bool isSelected,
    DateTime day,
    AttendanceStatus status,
    Function(DateTime v) onTap,
  ) {
    Color color;
    switch (status) {
      case AttendanceStatus.full:
        color = AppColors.success;
        break;
      case AttendanceStatus.lateOrEarly:
        color = AppColors.warning;
        break;
      case AttendanceStatus.missing:
        color = AppColors.error;
        break;
      case AttendanceStatus.empty:
        color = Colors.transparent;
        break;
    }

    return GestureDetector(
      onTap: () => onTap(day),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColors.backgroundInput : AppColors.border,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${day.day}",
              style: AppTypography.body(
                color: isSelected ? AppColors.primary : AppColors.text,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 11.sp,
              height: 11.sp,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
