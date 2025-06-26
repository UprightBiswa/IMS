import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF0061FE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color sidebarWhite = Color(0xFFFFFFFF);
  static const Color backgroundGray = Color(0xFFF7F9FA);
  static const Color lightGray = Color(0xFFE5E5E5);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color dangerRed = Color(0xFFF44336);

  static const Color primaryGreen = Color(0xFF4CAF50); // Green for progress
  static const Color primaryOrange = Color(0xFFFF9800); // Orange
  static const Color primaryRed = Color(0xFFF44336);


  static const Color accentGreen = Color(0xFF2ECC71);
  static const Color accentYellow = Color(0xFFF1C40F);
  static const Color accentRed = Color(0xFFE74C3C);

  static const Color textBlack = Color(0xFF333333);
  static const Color textGray = Color(0xFFA9A8AB);
  static const Color secondaryTextGray = Color(0xFF7E7E7E);
  static const Color lightGreyText = Color(0xFFBDBDBD);

  static const Color progressBlue = Color(0xFF3B82F6);

  static const Color borderGray = Color(0xFF5F5D5D);
  static const Color cardBackground = Color(0xFFF8F9FB);
  static const Color cardBorder = Color(0xFFEDEDED);
  static const Color darkBlue = Color(0xFF3949AB);

  static const Color lightGreyBackground = Color(0xFFF0F2F5);
  static const Color darkText = Color(0xFF212121); // Dark text
  static const Color greyText = Color(0xFF757575); // Grey text
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color accentBlue = Color(0xFF42A5F5);


// Colors for attendance UI (from previous steps)
  static const Color presentGreen = Color(0xFF4CAF50);
  static const Color absentRed = Color(0xFFF44336);
  static const Color lateOrange = Color(0xFFFF9800);
  static const Color leaveBlue = Color(0xFF2196F3);

  static const Color presentCalendarDot = Color(0xFF66BB6A); // Green dot
  static const Color absentCalendarDot = Color(0xFFEF5350); // Red dot
  static const Color lateCalendarDot = Color(0xFFFFCA28); // Yellow dot
  static const Color leaveCalendarDot = Color(0xFF3949AB);

  static const Color statusPresentGreen = Color(0xFFD4EDDA);
  static const Color statusPresentText = Color(0xFF28A745);
  static const Color statusAbsentRed = Color(0xFFF8D7DA);
  static const Color statusAbsentText = Color(0xFFDC3545);
  static const Color statusLeaveGrey = Color(0xFFE2E3E5);
  static const Color statusLeaveText = Color(0xFF6C757D);

  // New colors for Settings UI (based on image)
  static const Color settingsCardBackground = Color(0xFFFEFEFE);
  static const Color settingsCardBorder = Color(0xFFE0E0E0); // Faint border
  static const Color iconBackground = Color(0xFFF2F2F2); // Light grey for icon circles
  static const Color separatorLine = Color(0xFFF0F0F0);
  // Performance status colors
  static const Color performanceExcellent = Color(0xFF4CAF50); // Green
  static const Color performanceGood = Color(0xFF2196F3); // Blue
  static const Color performanceInProgress = Color(0xFFFFC107); // Yellow/Orange
  static const Color performanceBehind = Color(0xFFF44336); // Red

  static const Color logoutRed = Color(0xFFEF5350);

  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}
