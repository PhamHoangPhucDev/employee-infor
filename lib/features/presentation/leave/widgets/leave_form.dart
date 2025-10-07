import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/dropdown_button_formField_component.dart';
import '../../../../core/components/text_field_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../leave_controller.dart';

class LeaveForm extends StatefulWidget {
  final LeaveController controller;
  LeaveForm({Key? key, required this.controller}) : super(key: key);

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
              Text(
                "Đăng ký nghỉ phép cho tháng ${DateTime.now().month}",
                style: AppTypography.subtitle(),
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
                  return Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Bắt đầu"),
                            TextButtonComponent(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: widget.controller.startTime.value,
                                );
                                if (picked != null) {
                                  widget.controller.startTime.value = picked;
                                }
                              },
                              title: widget.controller.startTime.value.format(context),
                              color: AppColors.background,
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
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: widget.controller.endTime.value,
                                );
                                if (picked != null) {
                                  widget.controller.endTime.value = picked;
                                }
                              },
                              title: widget.controller.endTime.value.format(context),
                              color: AppColors.background,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),

              const SizedBox(height: 20),

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButtonComponent(
                    onPressed: widget.controller.backToMonth,
                    title: "Quay lại tháng",
                    width: 35.w,
                    color: AppColors.background,
                  ),
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
                    width: 20.w,
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ]),
          ),
        ],
      ),
    );
  }
}
