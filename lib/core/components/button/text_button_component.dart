import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class TextButtonComponent extends StatefulWidget {
  TextButtonComponent({super.key, this.title, this.onPressed, this.color = AppColors.primary, this.width, this.height, this.borderRadius,});
  final String? title;
  final VoidCallback? onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  State<TextButtonComponent> createState() => _TextButtonComponentState();
}

class _TextButtonComponentState extends State<TextButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,//65.w
      height: widget.height,//6.h
      child: ElevatedButton(
        onPressed: widget.onPressed??(){},
        style: ElevatedButton.styleFrom(
          padding: widget.height != null ?EdgeInsets.zero:null,
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
          ),
           side: widget.color != AppColors.primary
                ? BorderSide(
                    color: AppColors.primary,
                    width: 1,
                  )
                : BorderSide.none,
        ),
        child: Text(
          widget.title ?? 'App Button',
          style: AppTypography.button(color: widget.color != AppColors.primary ? AppColors.primary : AppColors.textLight)
        ),
      ),
    );
  }
}