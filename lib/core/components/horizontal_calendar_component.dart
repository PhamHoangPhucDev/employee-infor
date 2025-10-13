import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../features/data/models/attendance_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'section_header_component.dart';

/// HorizontalCalendarComponent: Lịch ngang cho phép chọn ngày, đổi tháng, highlight ngày đã chọn
class HorizontalCalendarComponent extends StatefulWidget {
  final Map<String, AttendanceStatus> events; // key: yyyy-MM-dd
  final DateTime? isSelectedDay; // ngày được chọn ban đầu (1-31)
  final Color? iconColor;
  final String? title;
  final ValueChanged<DateTime>? onDateSelected; // callback khi chọn ngày

  const HorizontalCalendarComponent({
    super.key,
    this.events = const {},
    this.isSelectedDay,
    this.iconColor = AppColors.buttonLight,
    this.title,
    this.onDateSelected,
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
        ? widget.isSelectedDay!
        : now;
    selectedDay = today;
    currentMonth = DateTime(today.year, today.month);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDay();
      _scrollController.addListener(_checkScroll);
    });
  }

  /// Đổi tháng (offset: ±1)
  void _changeMonth(int offset) {
    final newMonth = DateTime(currentMonth.year, currentMonth.month + offset, 1);

    setState(() => currentMonth = newMonth);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      // Nếu selectedDay nằm trong tháng hiện tại → scroll tới
      if (selectedDay.year == currentMonth.year &&
          selectedDay.month == currentMonth.month) {
        _scrollToSelectedDay();
      } else {
        // Tháng không chứa selectedDay → về đầu
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
      _checkScroll();
    });
  }

  /// Cuộn đến ngày đang chọn
  void _scrollToSelectedDay() {
    if (!_scrollController.hasClients) return;

    final dayIndex = selectedDay.day - 1;
    const margin = 8.0;
    final itemWidth = 12.w + margin;
    final targetOffset = dayIndex * itemWidth;

    _scrollController.animateTo(
      targetOffset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _checkScroll() {
    if (!_scrollController.hasClients) return;
    setState(() {
      _atStart = _scrollController.offset <= 0;
      _atEnd = _scrollController.offset >= _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollHorizontal(double offset) {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      (_scrollController.offset + offset)
          .clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  /// Màu dot trạng thái
  Color _getDotColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.full:
        return AppColors.success; // Duyệt
      case AttendanceStatus.lateOrEarly:
        return AppColors.warning; // Chưa duyệt
      case AttendanceStatus.missing:
        return AppColors.error; // Từ chối
      case AttendanceStatus.empty:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);

    return Column(
      children: [
        // Header tháng + nút chuyển tháng
        SectionHeaderComponent(
          title: widget.title ?? "",
          color: widget.iconColor!,
          trading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _changeMonth(-1),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowLeft01,
                  color: widget.iconColor!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  DateFormat('MM/yyyy').format(currentMonth),
                  style: AppTypography.body(color: widget.iconColor!),
                ),
              ),
              GestureDetector(
                onTap: () => _changeMonth(1),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight01,
                  color: widget.iconColor!,
                ),
              ),
            ],
          ),
        ),

        // Hàng lịch ngang
        Row(
          children: [
            // Nút trái
            SizedBox(
              width: 5.w,
              child: !_atStart
                  ? InkWell(
                      onTap: () => _scrollHorizontal(-200),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeft01,
                        size: 20.sp,
                        color: widget.iconColor,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            // Danh sách ngày
            Expanded(
              child: SizedBox(
                height: 10.h,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    final day = DateTime(currentMonth.year, currentMonth.month, index + 1);
                    final isSelected = selectedDay.year == day.year &&
                        selectedDay.month == day.month &&
                        selectedDay.day == day.day;
                    final key = DateFormat("yyyy-MM-dd").format(day);
                    final eventStatus = widget.events[key];

                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedDay = day);
                        widget.onDateSelected?.call(day);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 12.w,
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.background,
                                    AppColors.background.withValues(alpha: .95),
                                  ],
                                )
                              : LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withValues(alpha: .9),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.background,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${day.day}",
                              style: AppTypography.body(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textLight,
                              ),
                            ),
                            Text(
                              DateFormat.E().format(day).toUpperCase(),
                              style: isSelected
                                  ? AppTypography.body(color: AppColors.primary)
                                  : AppTypography.smallbody(color: AppColors.textLight),
                            ),
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

            // Nút phải
            SizedBox(
              width: 5.w,
              child: !_atEnd
                  ? InkWell(
                      onTap: () => _scrollHorizontal(200),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        size: 20.sp,
                        color: widget.iconColor,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}
