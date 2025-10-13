import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Component chọn khung giờ (Bắt đầu – Kết thúc)
/// Dùng Cupertino bottom sheet thay cho showTimePicker mặc định
class TimeRangePickerComponent extends StatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final ValueChanged<TimeOfDay> onStartChanged;
  final ValueChanged<TimeOfDay> onEndChanged;
  final Color? backgroundColor;

  const TimeRangePickerComponent({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.onStartChanged,
    required this.onEndChanged,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<TimeRangePickerComponent> createState() => _TimeRangePickerComponentState();
}

class _TimeRangePickerComponentState extends State<TimeRangePickerComponent> {
  String? _errorText;

  bool _isValidRange(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes >= startMinutes;
  }
  //showModelBottom chọn giờ
  Future<void> _pickTimeCupertino({
    required BuildContext context,
    required TimeOfDay initialTime,
    required ValueChanged<TimeOfDay> onChanged,
    required bool isStart,
  }) async {
    TimeOfDay selected = initialTime;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 40.h,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.disabled,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Text(
                isStart ? "Chọn giờ bắt đầu" : "Chọn giờ kết thúc",
                style: AppTypography.subtitle(),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(
                    hours: initialTime.hour,
                    minutes: initialTime.minute,
                  ),
                  onTimerDurationChanged: (duration) {
                    selected = TimeOfDay(
                      hour: duration.inHours,
                      minute: duration.inMinutes % 60,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              TextButtonComponent(
                onPressed: ()=>Navigator.pop(context),
                title: "Xác nhân",
                width: 100.w,
              )
            ],
          ),
        );
      },
    );

    setState(() {
      if (isStart) {
        if (_isValidRange(selected, widget.endTime)) {
          _errorText = null;
          onChanged(selected);
        } else {
          _errorText = "Giờ bắt đầu phải trước giờ kết thúc";
        }
      } else {
        if (_isValidRange(widget.startTime, selected)) {
          _errorText = null;
          onChanged(selected);
        } else {
          _errorText = "Giờ kết thúc phải sau giờ bắt đầu";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Bắt đầu"),
                  TextButtonComponent(
                    onPressed: () => _pickTimeCupertino(
                      context: context,
                      initialTime: widget.startTime,
                      onChanged: widget.onStartChanged,
                      isStart: true,
                    ),
                    title: widget.startTime.format(context),
                    color: widget.backgroundColor ?? AppColors.background,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Kết thúc"),
                  TextButtonComponent(
                    onPressed: () => _pickTimeCupertino(
                      context: context,
                      initialTime: widget.endTime,
                      onChanged: widget.onEndChanged,
                      isStart: false,
                    ),
                    title: widget.endTime.format(context),
                    color: widget.backgroundColor ?? AppColors.background,
                  ),
                ],
              ),
            ),
          ],
        ),
        /// Hiển thị lỗi có animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, -0.2),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: _errorText != null
              ? Padding(
                  key: ValueKey(_errorText),
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _errorText!,
                    style: AppTypography.smallbody(color: AppColors.error),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey("no_error")),
        ),
      ],
    );
  }
}
