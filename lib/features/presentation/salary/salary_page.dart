import 'package:flutter/material.dart';
import '../../../core/components/appBar_component.dart';
import '../../../core/components/button/circle_icon_button.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../data/models/salary_model.dart';
import 'package:hugeicons/hugeicons.dart';

class SalaryPage extends StatelessWidget {
  SalaryPage({super.key});

  final SalaryModel salary = SalaryModel(
    id: "1",
    fullname: "Lucy",
    role: "CEO",
    standardwd: "22",
    actualwd: "20.5",
    basicsalary: "70.000.000",
    paybywd: "3.181.818",
    monthlysalarybywd: "65.227.269",
    monthlysalaryoff: "65.227.269",
    support: "200.000",
    totalallowance: "400.000",
    advance: "1.000.000",
    discipline: "100.000",
    total: "1.100.000",
    responsibility: "0",
  );

  @override
  Widget build(BuildContext context) {
    final Map<String, String> salaryMap = salary.toMap();

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
        child: Card(
          color: AppColors.background,
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề bảng lương
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Bảng lương tháng ${DateTime.now().month}",
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
        ),
      ),
    );
  }
}