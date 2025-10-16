import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/appBar_component.dart';
import '../../../core/components/button/circle_icon_button.dart';
import '../../../core/components/horizontal_calendar_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../data/models/salary_model.dart';
import 'package:hugeicons/hugeicons.dart';

import 'salary_controller.dart';

class SalaryPage extends GetView<SalaryController> {
  SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> salaryMap = controller.salary.toMap();

    return Scaffold(
      backgroundColor: AppColors.backgroundInput,
      appBar: AppBarComponent(
        title: AppStrings.salaryTitle,
        actions: [
          CircleIconButton(
            icon: HugeIcons.strokeRoundedFileDownload,
            iconSize: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            HorizontalCalendarComponent(
              isMonthMode: true,
              iconColor: AppColors.primary,
              title: "Chọn tháng",
              isSelectedDay: controller.selectedMonth.value,
              onDateSelected: (value) {
                controller.selectedMonth.value = value;
              },
            ),
            SizedBox(height: 12),
            Expanded(
              child: Obx(() =>Card(
                color: AppColors.background,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề bảng lương
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Bảng lương tháng ${DateFormat('MM/yyyy').format(controller.selectedMonth.value)}",
                        style: AppTypography.subtitle(),
                      ),
                    ),
                    Divider(height: 1, color: AppColors.backgroundInput,),
                    // Danh sách chi tiết lương
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemCount: salaryMap.length,
                        itemBuilder: (context, index) {
                          String key = salaryMap.keys.elementAt(index);
                          String value = salaryMap[key]!;
              
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(key, style: AppTypography.body(color: AppColors.text.withValues(alpha: .8))),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(value, style: AppTypography.button(fW: FontWeight.bold,color: AppColors.text),textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(color: AppColors.backgroundInput,),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}