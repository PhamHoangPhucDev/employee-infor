import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class DropdownButtonFormFieldComponent extends StatelessWidget {
  final RxnString selectedValue;
  final List<String> listDropdown;
  final String label;

  const DropdownButtonFormFieldComponent({
    super.key,
    required this.selectedValue,
    required this.listDropdown,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
      isDense: true, // thu nhỏ chiều cao item
      initialValue: selectedValue.value,
      icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowDown01),
      dropdownColor: AppColors.backgroundInput,// màu nền của menu xổ xuống
      decoration: InputDecoration(
        // isDense: true, // thu nhỏ ô input
        labelText: label,
        labelStyle: AppTypography.body(),
        filled: true,
        fillColor: AppColors.backgroundInput,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.backgroundInput, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
      items: listDropdown
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type,style: AppTypography.body(),),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) selectedValue.value = value;
      },
    ));
  }
}

