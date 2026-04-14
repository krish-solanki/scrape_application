import 'package:flutter/material.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

class AppTheme {
  // 🔷 LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,

    primaryColor: AppColors.primary,

    colorScheme:  ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.highlight,
    ),

    textTheme:  TextTheme(
      headlineLarge: AppTextStyles.heading,
      titleMedium: AppTextStyles.subHeading,
      bodyMedium: AppTextStyles.body,
      labelMedium: AppTextStyles.label,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.highlight,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  // 🔷 DARK THEME (YOUR LOGIN UI STYLE)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,

    primaryColor: AppColors.primary,

    colorScheme:  ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.highlight,
    ),

    textTheme:  TextTheme(
      headlineLarge: AppTextStyles.heading,
      titleMedium: AppTextStyles.subHeading,
      bodyMedium: AppTextStyles.body,
      labelMedium: AppTextStyles.label,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accent, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.highlight,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}