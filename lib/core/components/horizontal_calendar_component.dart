import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../features/data/models/attendance_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'section_header_component.dart';

/// HorizontalCalendarComponent: Lịch ngang cho phép chọn ngày/tháng, đổi tháng/năm
class HorizontalCalendarComponent extends StatefulWidget {
  final Map<String, AttendanceStatus> events; // key: yyyy-MM-dd hoặc yyyy-MM
  final DateTime? isSelectedDay; // ngày/tháng được chọn ban đầu
  final Color? iconColor;
  final String? title;
  final ValueChanged<DateTime>? onDateSelected; // callback khi chọn ngày/tháng
  final bool isMonthMode; // true: hiển thị 12 tháng, false: hiển thị ngày

  const HorizontalCalendarComponent({
    super.key,
    this.events = const {},
    this.isSelectedDay,
    this.iconColor = AppColors.buttonLight,
    this.title,
    this.onDateSelected,
    this.isMonthMode = false,
  });

  @override
  State<HorizontalCalendarComponent> createState() => _HorizontalCalendarStateComponent();
}

class _HorizontalCalendarStateComponent extends State<HorizontalCalendarComponent> {
  late DateTime today;
  late DateTime selectedDay;
  late DateTime currentMonth;
  late int currentYear;
  final ScrollController _scrollController = ScrollController();

  bool _atStart = true;
  bool _atEnd = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    today = widget.isSelectedDay ?? now;
    selectedDay = today;
    currentMonth = DateTime(today.year, today.month);
    currentYear = today.year;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
      _scrollController.addListener(_checkScroll);
    });
  }

  /// Đổi tháng/năm (offset: ±1)
  void _changeMonth(int offset) {
    if (widget.isMonthMode) {
      // Chế độ tháng: đổi năm
      setState(() => currentYear += offset);
    } else {
      // Chế độ ngày: đổi tháng
      final newMonth = DateTime(currentMonth.year, currentMonth.month + offset, 1);
      setState(() => currentMonth = newMonth);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      if (widget.isMonthMode) {
        // Scroll tới tháng đang chọn nếu trong năm hiện tại
        if (selectedDay.year == currentYear) {
          _scrollToSelected();
        } else {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      } else {
        // Scroll tới ngày đang chọn nếu trong tháng hiện tại
        if (selectedDay.year == currentMonth.year &&
            selectedDay.month == currentMonth.month) {
          _scrollToSelected();
        } else {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      }
      _checkScroll();
    });
  }

  /// Cuộn đến ngày/tháng đang chọn
  void _scrollToSelected() {
    if (!_scrollController.hasClients) return;

    final index = widget.isMonthMode
        ? selectedDay.month - 1
        : selectedDay.day - 1;
    
    const margin = 8.0;
    final itemWidth = 12.w + margin;
    final targetOffset = index * itemWidth;

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
        return AppColors.success;
      case AttendanceStatus.lateOrEarly:
        return AppColors.warning;
      case AttendanceStatus.missing:
        return AppColors.error;
      case AttendanceStatus.empty:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.isMonthMode
        ? 12
        : DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);

    return Column(
      children: [
        // Header tháng/năm + nút chuyển
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
                  widget.isMonthMode
                      ? currentYear.toString()
                      : DateFormat('MM/yyyy').format(currentMonth),
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
        SizedBox(
          height: 10.h,
          child: Row(
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
          
              // Danh sách ngày/tháng
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final DateTime item;
                    final bool isSelected;
                    final String key;
                    final String displayText;
                    final String subText;
                
                    if (widget.isMonthMode) {
                      // Chế độ tháng
                      item = DateTime(currentYear, index + 1);
                      isSelected = selectedDay.year == item.year &&
                          selectedDay.month == item.month;
                      key = DateFormat("yyyy-MM").format(item);
                      displayText = DateFormat('MM').format(item);
                      subText = DateFormat('MMM').format(item).toUpperCase();
                    } else {
                      // Chế độ ngày
                      item = DateTime(currentMonth.year, currentMonth.month, index + 1);
                      isSelected = selectedDay.year == item.year &&
                          selectedDay.month == item.month &&
                          selectedDay.day == item.day;
                      key = DateFormat("yyyy-MM-dd").format(item);
                      displayText = "${item.day}";
                      subText = DateFormat.E().format(item).toUpperCase();
                    }
                
                    final eventStatus = widget.events[key];
                
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedDay = item);
                        widget.onDateSelected?.call(item);
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
                              displayText,
                              style: AppTypography.body(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textLight,
                              ),
                            ),
                            Text(
                              subText,
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
        ),
      ],
    );
  }
}