import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../features/data/models/attendance_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Trạng thái của sự kiện

class HorizontalCalendarComponent extends StatefulWidget {
  final Map<String, AttendanceStatus> events; // key: yyyy-MM-dd
  int? isSelectedDay;
  Color? iconColor;

  HorizontalCalendarComponent({
    super.key,
    this.events = const {}, // mặc định rỗng
    this.isSelectedDay, 
    this.iconColor = AppColors.buttonLight
  });

  @override
  State<HorizontalCalendarComponent> createState() => _HorizontalCalendarStateComponent();
}

class _HorizontalCalendarStateComponent extends State<HorizontalCalendarComponent> {
  late DateTime today;
  late DateTime selectedDay;
  late DateTime currentMonth;
  final ScrollController _scrollController = ScrollController();

  bool _atStart = true;
  bool _atEnd = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    today = widget.isSelectedDay != null
      ? DateTime(now.year, now.month, widget.isSelectedDay!) // lấy năm & tháng hiện tại
      : now;
    selectedDay = today;
    currentMonth = DateTime(today.year, today.month);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
      _scrollController.addListener(_checkScroll);
    });
  }

  void _checkScroll() {
    if (!_scrollController.hasClients) return;
    setState(() {
      _atStart = _scrollController.offset <= 0;
      _atEnd = _scrollController.offset >= _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollToToday() {
    int dayIndex = today.day - 1;
    // Chiều rộng item thực tế: 12.w + margin horizontal * 2
    double itemWidth = 12.w + 8; // vì margin horizontal: 4
    double targetOffset = dayIndex * itemWidth;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  void _scrollLeft() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      (_scrollController.offset - 200).clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      (_scrollController.offset + 200).clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  /// Trả về màu dot theo trạng thái
  Color _getDotColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.full://duyệt
        return AppColors.success;
      case AttendanceStatus.lateOrEarly://chưa duyệt
        return AppColors.warning;
      case AttendanceStatus.missing://từ chối
        return AppColors.error;
      case AttendanceStatus.empty:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);

    return Column(
      children: [
        Row(
          children: [
            //Nút trái
            if (!_atStart)
              SizedBox(
                width: 5.w,
                child: InkWell(
                  onTap: _scrollLeft,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    size: 20.sp,
                    color: widget.iconColor,
                  ),
                ),
              )
            else
              SizedBox(width: 5.w),
            Expanded(
              child: SizedBox(
                height: 10.h,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    DateTime day = DateTime(currentMonth.year, currentMonth.month, index + 1);
                    bool isSelected = selectedDay.year == day.year &&
                                    selectedDay.month == day.month &&
                                    selectedDay.day == day.day;
                    String key = DateFormat("yyyy-MM-dd").format(day);
                    AttendanceStatus? eventStatus = widget.events[key];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                      child: Container(
                        width: 12.w,
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.background : AppColors.primary,
                          border: Border.all(
                            width: 1,
                            color: isSelected?AppColors.primary:AppColors.background,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${day.day}",
                              style: AppTypography.body(
                                color: isSelected ? AppColors.primary : AppColors.textLight,
                              ),
                            ),
                            Text(
                              DateFormat.E().format(day).toUpperCase(),
                              style: isSelected
                                  ? AppTypography.body(color: AppColors.primary)
                                  : AppTypography.smallbody(color: AppColors.textLight),
                            ),
                            // dot trạng thái
                            if (eventStatus != null)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: _getDotColor(eventStatus),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            //nút phải
            if (!_atEnd)
              SizedBox(
                width: 5.w,
                child: InkWell(
                  onTap: _scrollRight,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowRight01,
                    size: 20.sp,
                    color: widget.iconColor,
                  ),
                ),
              )
            else
              SizedBox(width: 5.w),
          ],
        ),
      ],
    );
  }
}
