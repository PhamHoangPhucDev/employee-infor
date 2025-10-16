import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/app_dialog_component.dart.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final VoidCallback? onConfirm;

  const ProjectCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppDialogComponent.show(
        context: context,
        title: "Dự án",
        type: DialogType.alertDialog,
        confirmText: "Sửa",
        confirmColor: AppColors.primary,
        fields: [
          Text("Admin Studio", style: AppTypography.body()),
          Text("01/2025 - Hiện tại", style: AppTypography.smallbody()),
        ],
        onConfirm: onConfirm??(){},
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundInput,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: .05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.body(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedBuilding03,
                            color: AppColors.icon,
                            size: 16.sp,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              company,
                              style: AppTypography.smallbody(color: AppColors.icon),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedLocation01,
                            color: AppColors.icon,
                            size: 16.sp,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              location,
                              style: AppTypography.smallbody(color: AppColors.icon),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "Dự án",
                      style: AppTypography.smallbody(color: AppColors.textLight),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
