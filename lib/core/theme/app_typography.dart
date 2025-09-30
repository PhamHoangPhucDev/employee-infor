// Định nghĩa kiểu văn bản cho ứng dụng
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Base style (có thể extend lại)
  static TextStyle base = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14.sp,
    color: AppColors.text,
  );

  static TextStyle display ({Color color = AppColors.text}) => base.copyWith(
    fontSize: 48.sp,
    fontWeight: FontWeight.bold,
    color: color,
  );
  static TextStyle headline({Color color = AppColors.text}) => base.copyWith(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle subtitle ({Color color = AppColors.text}) => base.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle body ({Color color = AppColors.text}) => base.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: color,
  );

  static TextStyle smallbody ({Color color = AppColors.text, decoration}) => base.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: color,
    decoration: decoration
  );

  static TextStyle caption ({Color color = AppColors.text}) => base.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: color,
  );

  // Small text
  static TextStyle small ({Color color = AppColors.text}) => base.copyWith(
    fontSize: 10.sp,
    fontWeight: FontWeight.w300,
    color: color,
  );

  // Button text
  static TextStyle button({Color color = AppColors.background}) => base.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: color,
  );
}
