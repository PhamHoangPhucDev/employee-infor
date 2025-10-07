import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'text_button_component.dart';

class ConfirmBottomSheet extends StatelessWidget {
  final List<List<dynamic>>? icon;
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final Color confirmColor;
  final VoidCallback onConfirm;

  const ConfirmBottomSheet({
    Key? key,
    required this.title,
    required this.message,
    this.cancelText = "Hủy",
    this.confirmText = "Xác nhận",
    this.confirmColor = AppColors.primary,
    required this.onConfirm, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!=null 
              ? HugeIcon(icon: icon!,color: confirmColor,size: 30.sp,)
              : SizedBox.shrink(),
            SizedBox(height: 12),
            Text(
              title,
              style: AppTypography.body(),
            ),
            SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.smallbody(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButtonComponent(
                    title: cancelText,
                    color: AppColors.background,
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextButtonComponent(
                    title: confirmText,
                    color: confirmColor,
                    onPressed: () {
                      Navigator.pop(context, true);
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showConfirmBottomSheet({
  required String title,
  required String message,
  required VoidCallback onConfirm,
  String cancelText = "Hủy",
  String confirmText = "Xác nhận",
  Color confirmColor = AppColors.primary,
  List<List<dynamic>>? icon
}) {
  return Get.bottomSheet(
    ConfirmBottomSheet(
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      confirmColor: confirmColor,
      onConfirm: onConfirm,
      icon: icon,
    ),
    isScrollControlled: true,
    barrierColor: AppColors.primary.withValues(alpha: .25),
    backgroundColor: AppColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
  );
}
