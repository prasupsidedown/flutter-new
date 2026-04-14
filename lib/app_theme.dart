import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFFEF9F1);
  static const Color surface = Color(0xFFF8F3EB);
  static const Color primary = Color(0xFF1A3328);
  static const Color accent = Color(0xFF805600);
  static const Color accentLight = Color(0xFFFDBA4F);
  static const Color textPrimary = Color(0xFF041E14);
  static const Color textSecondary = Color(0xFF424844);
  static const Color textMuted = Color(0xFFC2C8C3);
  static const Color error = Color(0xFFBA1A1A);
  static const Color cardBorder = Color(0xFFE7E2DA);
  static const Color successDark = Color(0xFF065F46);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          background: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        fontFamily: 'sans-serif',
      );
}
