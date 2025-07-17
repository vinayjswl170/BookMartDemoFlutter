
import 'package:flutter/material.dart';
import 'package:gutendex_books_app/utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    fontFamily: 'Montserrat',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary, // Default App Bar background (for Category Page)
      foregroundColor: AppColors.backgroundLight,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.backgroundLight,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w600, color: AppColors.greyDark),
      displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.greyDark), // Heading 2
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: AppColors.backgroundLight), // Genre Card Text
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.greyDark), // Body, Search Box input
      bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.greyDark), // Book Name (default 12px)
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.greyMedium), // Book Author (default 12px)
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal, fontFamily: 'Montserrat'), // Genre Card text style
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.greyMedium, fontSize: 16, fontFamily: 'Montserrat'),
      labelStyle: const TextStyle(color: AppColors.greyDark, fontFamily: 'Montserrat'),
      fillColor: AppColors.greyLight,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
