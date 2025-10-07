import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// ThemeData chính của app
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      displayLarge: AppTypography.display(),
      bodyLarge: AppTypography.headline(),
    ),
    
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.background; // khi bật
        }
        return AppColors.background; // khi tắt
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary; // track khi bật
        }
        return AppColors.buttonLight; // track khi tắt
      }),
      // xoá viền mặc định khi tắt
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}
