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
  );
}
