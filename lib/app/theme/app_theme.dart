import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundGray,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      primary: AppColors.primaryBlue,
      secondary: AppColors.accentGreen,
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      bodyLarge: const TextStyle(color: AppColors.textBlack),
      bodyMedium: const TextStyle(color: AppColors.secondaryTextGray),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.sidebarWhite,
      foregroundColor: AppColors.sidebarWhite,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.secondaryTextGray),
      titleTextStyle: TextStyle(
        color: AppColors.secondaryTextGray,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );
}

SystemUiOverlayStyle defaultOverlay = const SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.light,
);
