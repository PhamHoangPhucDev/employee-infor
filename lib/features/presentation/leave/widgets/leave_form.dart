// lib/features/leave/widgets/leave_form.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_dropdownButtonFormField.dart';
import '../../../../core/components/app_textField.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../leave_controller.dart';
import 'package:get/get.dart';

class LeaveForm extends StatefulWidget {
  final LeaveController controller;
  const LeaveForm({Key? key, required this.controller}) : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Đăng ký nghỉ phép cho tháng ${DateTime.now().month}", style: AppTypography.subtitle(),),
            const SizedBox(height: 15),
      
            DropdownButtonFormFieldComponent(
              selectedValue: widget.controller.leaveType,
              listDropdown: widget.controller.leaveTypes,
              label: "Loại nghỉ phép",
            ),
      
            // Nếu chọn "Theo giờ" thì hiện thêm chọn giờ
            Obx(() {
              if (widget.controller.leaveType.value == "Theo giờ") {
                return Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Bắt đầu"),
                          AppButtonComponent(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Kết thúc"),
                          AppButtonComponent(
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
                return const SizedBox.shrink(); // return widget rỗng khi không phải "Theo giờ"
              }
            }),
      
            SizedBox(height: 20,),
        
            /// Dropdown chọn lý do (GetX)
            DropdownButtonFormFieldComponent(
              selectedValue: widget.controller.selectedReason,
              listDropdown: widget.controller.reasons,
              label: "Lý do xin nghỉ",
            ),
            SizedBox(height: 16),
        
            /// Text ghi chú
            AppTextfieldComponent(
              controller: widget.controller.noteController,
              label: "Ghi chú",
              hintText: "Ghi chú thêm (nếu có)",
              maxLines: 3,
            ),
            SizedBox(height: 16),
        
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButtonComponent(
                  onPressed: widget.controller.backToMonth,
                  title: "Quay lại tháng",
                  width: 35.w,
                  color: AppColors.background,
                ),
                AppButtonComponent(
                  onPressed: () {
                    // TODO: call API để gửi đơn nghỉ -> sau đó cập nhật leaveDays/ trạng thái
                    Get.snackbar(
                      "Thành công",
                      "Bạn đã xin nghỉ: ${widget.controller.leaveType.value}${widget.controller.leaveType.value == "Theo giờ"
                              ? " (${widget.controller.startTime.value.format(context)} - ${widget.controller.endTime.value.format(context)})"
                              : ""}",
                    );
                  },
                  title: "Gửi",
                  width: 20.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
