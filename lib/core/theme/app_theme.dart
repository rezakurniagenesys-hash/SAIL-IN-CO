import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: AppColors.sky950,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(titleLarge: AppTextStyles.title, bodyMedium: AppTextStyles.body),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: AppColors.textPrimary, elevation: 0),
    );
  }
}
