import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/dropdown_button_formField_component.dart';
import '../../../../core/components/text_field_component.dart';
import '../../../../core/components/timeRangePickerComponent.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../leave_controller.dart';

class LeaveForm extends StatefulWidget {
  LeaveForm({Key? key, required this.controller}) : super(key: key);
  final LeaveController controller;

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: Obx(() =>Text(
                  "Đăng ký nghỉ ngày ${DateFormat('dd/MM/yyyy').format(widget.controller.selectedDay.value)}",
                  style: AppTypography.subtitle(),
                )),
              ),
              const SizedBox(height: 15),

              /// Dropdown loại nghỉ phép
              DropdownButtonFormFieldComponent(
                selectedValue: widget.controller.leaveType,
                listDropdown: widget.controller.leaveTypes,
                label: "Loại nghỉ phép",
              ),

              /// Nếu chọn "Theo giờ" thì hiện thêm chọn giờ
              Obx(() {
                if (widget.controller.leaveType.value == "Theo giờ") {
                  return TimeRangePickerComponent(
                    startTime: widget.controller.startTime.value,
                    endTime: widget.controller.endTime.value,
                    onStartChanged: (v) => widget.controller.startTime.value = v,
                    onEndChanged: (v) =>  widget.controller.endTime.value = v,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),

              const SizedBox(height: 16),

              /// Dropdown chọn lý do
              DropdownButtonFormFieldComponent(
                selectedValue: widget.controller.selectedReason,
                listDropdown: widget.controller.reasons,
                label: "Lý do xin nghỉ",
              ),
              const SizedBox(height: 16),

              /// Ghi chú
              TextFieldComponent(
                controller: widget.controller.noteController,
                label: "Ghi chú",
                hintText: "Ghi chú thêm (nếu có)",
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              /// Buttons
              TextButtonComponent(
                onPressed: () {
                  Get.snackbar(
                    "Thành công",
                    "Bạn đã xin nghỉ: ${widget.controller.leaveType.value}"
                        "${widget.controller.leaveType.value == "Theo giờ"
                            ? " (${widget.controller.startTime.value.format(context)} - ${widget.controller.endTime.value.format(context)})"
                            : ""}",
                  );
                },
                title: "Gửi",
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
