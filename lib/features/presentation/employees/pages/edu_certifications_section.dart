import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/components/app_dialog_component.dart.dart';
import '../../../../core/components/listTile_icon_component.dart';
import '../../../../core/components/section_header_component.dart';
import '../../../../core/components/text_field_component.dart';
import '../../../../core/theme/app_colors.dart';

class EduCertificationsSection extends StatelessWidget {
  const EduCertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeaderComponent(
          title: "Học vấn",
          trading: HugeIcon(icon: HugeIcons.strokeRoundedAddSquare,color: AppColors.primary,),
          onActionPressed: () => AppDialogComponent.show(
            context: context,
            title: "Thêm trường",
            type: DialogType.bottomSheet,
            confirmText: "Thêm",
            confirmColor: AppColors.primary,
            fields: [
              TextFieldComponent(label: "Tên trường", controller: TextEditingController()),
              TextFieldComponent(label: "Năm học", controller: TextEditingController()),
            ],
            onConfirm: (){},
          ),
        ),
        SizedBox(height: 5,),
        Card(
          color: AppColors.background,
          child: ListTileIconComponent(
            icon: HugeIcons.strokeRoundedMortarboard02,
            title: "Ton Duc Thang University",
            subtitle: "01/07/2020 - 01/11/2025",
            trailing: HugeIcon(icon: HugeIcons.strokeRoundedPencilEdit02,color: AppColors.primary,),
          ),
        ),
        SizedBox(height: 20,),
        SectionHeaderComponent(
          title: "Chứng nhận",
          trading: HugeIcon(icon: HugeIcons.strokeRoundedAddSquare,color: AppColors.primary,),
          onActionPressed: () => AppDialogComponent.show(
            context: context,
            title: "Thêm chứng nhận",
            type: DialogType.bottomSheet,
            confirmText: "Thêm",
            confirmColor: AppColors.primary,
            fields: [
              TextFieldComponent(label: "Tên bằng cấp", controller: TextEditingController()),
              TextFieldComponent(label: "Năm nhận bằng", controller: TextEditingController()),
            ],
            onConfirm: (){},
          ),
        ),
        SizedBox(height: 5,),
        Card(
          color: AppColors.background,
          child: ListTileIconComponent(
            icon: HugeIcons.strokeRoundedMedalFirstPlace,
            title: "Adobe Certified Expert (Photoshop, Illustrator, XD)",
            subtitle: "Ngày: 20/10/2025",
            trailing: HugeIcon(icon: HugeIcons.strokeRoundedPencilEdit02,color: AppColors.primary,),
          ),
        ),
        Card(
          color: AppColors.background,
          child: ListTileIconComponent(
            icon: HugeIcons.strokeRoundedMedalSecondPlace,
            title: "Google UX Design Professional Certificate",
            subtitle: "Ngày: 10/10/2025",
            trailing: HugeIcon(icon: HugeIcons.strokeRoundedPencilEdit02,color: AppColors.primary,),
          ),
        ),
        Card(
          color: AppColors.background,
          child: ListTileIconComponent(
            icon: HugeIcons.strokeRoundedMedalThirdPlace,
            title: "Interaction Design Foundation (IDF) Certificates",
            subtitle: "Ngày: 01/10/2025",
            trailing: HugeIcon(icon: HugeIcons.strokeRoundedPencilEdit02,color: AppColors.primary,),
          ),
        ),

      ],
    );
  }
}