import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../features/data/models/attendance_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'section_header_component.dart';

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

  //Ghi chú dot
  final List<String> notesDot;
  final List<Color> notecolorsDot;
  //tháng được chọn
  final DateTime? month;
  //tiêu đề
  final String? title;

  MonthGridViewComponent({
    super.key,
    this.getStatus,
    this.onDaySelected,
    this.initialSelectedDay, 
    this.events,
    this.month,
    this.title,
    List<String>? notesDot,
    List<Color>? notecolorsDot,
  }): notesDot = notesDot ?? const ["Đủ giờ", "Trễ/Sớm", "Thiếu"],
        notecolorsDot = notecolorsDot ??
            const [AppColors.success, AppColors.warning, AppColors.error];

  @override
  State<MonthGridViewComponent> createState() => _MonthGridViewComponentState();
}

class _MonthGridViewComponentState extends State<MonthGridViewComponent> {
  late DateTime currentMonth;
  late DateTime selectedDay;
  late List<DateTime?> days;

  @override
  void initState() {
    super.initState();
    currentMonth = widget.month ?? DateTime.now();
    selectedDay = widget.initialSelectedDay ?? DateTime.now();
    days = generateMonthDays(widget.month??DateTime.now()); // tháng hiện tại
  }

  void _changeMonth(int offset) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + offset);
      days = generateMonthDays(currentMonth);
    });
  }

  /// Sinh danh sách ngày bao gồm các ô trống để canh đúng thứ
  List<DateTime?> generateMonthDays(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekday = firstDay.weekday; // Thứ bắt đầu: 1 = T2, 7 = CN

    // Thêm các ô trống trước ngày 1
    final List<DateTime?> list = List.filled(firstWeekday - 1, null, growable: true);

    // Thêm tất cả ngày trong tháng
    for (int i = 1; i <= daysInMonth; i++) {
      list.add(DateTime(month.year, month.month, i));
    }

    return list;
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatKey(DateTime d) =>
      "${d.year.toString().padLeft(4, '0')}-"
      "${d.month.toString().padLeft(2, '0')}-"
      "${d.day.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeaderComponent(
          title: widget.title??"",
          trading: _selectMonth(widget.month),
        ),
        SizedBox(height: 10,),
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            if (day == null) {
              // Ô trống trước ngày đầu tháng
              return const SizedBox.shrink();
            }
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

        const SizedBox(height: 8),
        Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.notesDot.length,
            (i) => _legendItem(widget.notecolorsDot[i], widget.notesDot[i]),
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
        clipBehavior: Clip.hardEdge,
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
                color: isSelected 
                  ? AppColors.primary : 
                    (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday
                      ?AppColors.primary
                      :AppColors.text
                    ),
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


  Widget _selectMonth(DateTime? month) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _changeMonth(-1),
          child: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01,color: AppColors.primary),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            DateFormat('MM/yyyy').format(currentMonth),
            style: AppTypography.body(color: AppColors.primary),
          ),
        ),
        GestureDetector(
          onTap: () => _changeMonth(1),
          child: const HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01,color: AppColors.primary),
        ),
      ],
    );
  }
}

Widget _legendItem(Color color, String label) {
  return Row(
    children: [
      if (color != Colors.transparent)
        Container(
          width: 13.sp,
          height: 13.sp,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      if (color == Colors.transparent) const SizedBox(width: 16, height: 16),
      const SizedBox(width: 6),
      Text(label, style: AppTypography.smallbody()),
    ],
  );
}
