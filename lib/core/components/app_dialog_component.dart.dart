import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/button/text_button_component.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'button/circle_icon_button.dart';

/// Loại hiển thị: bottom sheet hoặc alert dialog
enum DialogType { bottomSheet, alertDialog }

class AppDialogComponent {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required List<Widget> fields,
    required VoidCallback onConfirm,
    String confirmText = "Xác nhận",
    String removeText = "Hủy",
    bool showRemove = false,
    Color confirmColor = AppColors.primary,
    Color removeColor = AppColors.backgroundInput,
    DialogType type = DialogType.bottomSheet,
  }) async {
    if (type == DialogType.bottomSheet) {
      // Hiển thị dạng BottomSheet trượt lên
      await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Dismiss",
        barrierColor: AppColors.text.withValues(alpha:0.5),
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransitionDialog(
              child: Material(
                color: AppColors.background,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    top: 20,
                  ),
                  child: _DialogContent(
                    title: title,
                    fields: fields,
                    onConfirm: onConfirm,
                    confirmText: confirmText,
                    removeText: removeText,
                    showRemove: showRemove,
                    confirmColor: confirmColor,
                    removeColor: removeColor,
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(anim),
            child: FadeTransition(opacity: anim, child: child),
          );
        },
      );
    } else {
      // Hiển thị dạng AlertDialog (fade + zoom in)
      await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Dismiss",
        barrierColor: AppColors.text.withValues(alpha:0.3),
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (_, __, ___) {
          return FadeScaleDialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Center(
                child: Material(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _DialogContent(
                      title: title,
                      fields: fields,
                      onConfirm: onConfirm,
                      confirmText: confirmText,
                      removeText: removeText,
                      showRemove: showRemove,
                      confirmColor: confirmColor,
                      removeColor: removeColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

//Nội dung chính bên trong dialog
class _DialogContent extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final VoidCallback onConfirm;
  final String confirmText;
  final String removeText;
  final bool showRemove;
  final Color confirmColor;
  final Color removeColor;

  const _DialogContent({
    required this.title,
    required this.fields,
    required this.onConfirm,
    required this.confirmText,
    required this.removeText,
    required this.showRemove,
    required this.confirmColor,
    required this.removeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Tiêu đề căn giữa
            Center(
              child: Text(
                title,
                style: AppTypography.subtitle(),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              right: 0,
              child: CircleIconButton(
                icon: HugeIcons.strokeRoundedCancel01,
                iconSize: 16.sp,
                iconColor: AppColors.background.withValues(alpha: 0.8),
                backgroundColor: AppColors.primaryRed.withValues(alpha: 0.9),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
        Divider(color: AppColors.disabled,),
        ...fields,
        SizedBox(height: 3.h),
        Row(
          children: [
            if (showRemove)
              Expanded(
                child: TextButtonComponent(
                  title: removeText,
                  color: removeColor,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            if (showRemove) const SizedBox(width: 8),
            Expanded(
              child: TextButtonComponent(
                title: confirmText,
                color: confirmColor,
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Hiệu ứng trượt lên cho bottom sheet
class SlideTransitionDialog extends StatelessWidget {
  final Widget child;
  const SlideTransitionDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 100.0, end: 0.0),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      builder: (_, double value, __) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
    );
  }
}

// Hiệu ứng fade + scale cho dialog
class FadeScaleDialog extends StatelessWidget {
  final Widget child;
  const FadeScaleDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.9, end: 1.0),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutBack,
      builder: (_, double scale, __) {
        return Transform.scale(
          scale: scale,
          child: Opacity(opacity: scale.clamp(0.0, 1.0), child: child),
        );
      },
    );
  }
}
