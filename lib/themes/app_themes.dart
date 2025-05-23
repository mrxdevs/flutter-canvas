import 'package:flutter/material.dart';
import 'package:flutter_canvas/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkPrimary, // You can define a secondary color
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      onPrimary: AppColors.lightOnPrimary,
      onSecondary: AppColors.lightOnPrimary,
      onBackground: AppColors.lightOnBackground,
      onSurface: AppColors.lightOnSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightAppBar,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.lightOnBackground),
      titleTextStyle: GoogleFonts.lato(
        color: AppColors.lightOnBackground,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: GoogleFonts.latoTextTheme(
      ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(color: AppColors.lightOnBackground),
            bodyMedium: const TextStyle(color: AppColors.lightOnBackground),
            titleLarge: const TextStyle(
                color: AppColors.lightOnBackground,
                fontWeight: FontWeight.bold),
          ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.lightOnPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightOnBackground),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkPrimary, // You can define a secondary color
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.darkOnPrimary,
      onSecondary: AppColors.darkOnPrimary,
      onBackground: AppColors.darkOnBackground,
      onSurface: AppColors.darkOnSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkAppBar,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.darkOnSurface),
      titleTextStyle: GoogleFonts.lato(
        color: AppColors.darkOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.darkCard,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: GoogleFonts.latoTextTheme(
      ThemeData.dark().textTheme.copyWith(
            bodyLarge: const TextStyle(color: AppColors.darkOnBackground),
            bodyMedium: const TextStyle(color: AppColors.darkOnBackground),
            titleLarge: const TextStyle(
                color: AppColors.darkOnBackground, fontWeight: FontWeight.bold),
          ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkOnPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.darkOnSurface),
  );
}
