import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/app_dialog_component.dart.dart';
import '../../../../core/components/fancy_icon.dart';
import '../../../../core/components/section_header_component.dart';
import '../../../../core/components/text_field_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SkillsLanguagesSection extends StatelessWidget {
  const SkillsLanguagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderComponent(
          title: "Kỹ năng",
          trading: HugeIcon(icon: HugeIcons.strokeRoundedAddSquare,color: AppColors.primary,),
          onActionPressed: () => AppDialogComponent.show(
            context: context,
            title: "Thêm kỹ năng",
            type: DialogType.bottomSheet,
            confirmText: "Thêm",
            confirmColor: AppColors.primary,
            fields: [
              TextFieldComponent(label: "Kỹ năng", controller: TextEditingController()),
            ],
            onConfirm: (){},
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildItem("Wireframing & Prototyping"),
            _buildItem("Adobe Suite"),
            _buildItem("Figma"),
            _buildItem("Canva"),
            _buildItem("Time Management"),
          ],
        ),
        const SizedBox(height: 20),
        SectionHeaderComponent(
          title: "Ngôn ngữ",
          trading: HugeIcon(icon: HugeIcons.strokeRoundedAddSquare,color: AppColors.primary,),
          onActionPressed: () => AppDialogComponent.show(
            context: context,
            title: "Thêm ngôn ngữ",
            type: DialogType.bottomSheet,
            confirmText: "Thêm",
            confirmColor: AppColors.primary,
            fields: [
              TextFieldComponent(label: "Ngôn ngữ", controller: TextEditingController()),
            ],
            onConfirm: (){},
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildItem("Tiếng Anh"),
            _buildItem("Tiếng Trung"),
            _buildItem("Tiếng Pháp"),
          ],
        ),
      ],
    );
  }
}

Widget _buildItem(String title){
  return FeatureCardBase(
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: Text(
      title,
      style: AppTypography.smallbody(color: AppColors.text),
    ),
  );
}