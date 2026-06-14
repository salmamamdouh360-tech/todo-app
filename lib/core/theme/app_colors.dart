import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static List<Color> ground = [
    Color(0xFF0D2550),
    Color(0xFF143272),
    Color(0xFF1A3A80),
    Color(0xFF1E4494),
  ];
  // Backgrounds
  static const Color bgDark = Color(0xFF0D2550);
  static const Color bgMedium = Color(0xFF143272);
  static const Color bgCard = Color(0xFF1A3A80);
  static const Color bgCardLight = Color(0xFF1E4494);

  // Accents
  static const Color accentCyan = Color(0xFF4DD9F0);
  static const Color accentGreen = Color(0xFF34C759);
  static const Color accentRed = Color(0xFFFF3B30);
  static const Color accentYellow = Color(0xFFFFCC00);
  static const Color accentOrange = Color(0xFFFF9500);

  // Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFFCCDDFF);
  static const Color textMuted = Color(0xFF8899CC);
  static const Color textDisabled = Color(0xFF556699);

  // Today highlight
  static const Color todayBg = Color(0xFF4DD9F0);
  static const Color todayText = Color(0xFF0D2550);

  // Weekend highlight
  static const Color weekendText = Color(0xFFFF6B6B);
}

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle pageTitle = TextStyle(
    color: AppColors.textWhite,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.textWhite,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    color: AppColors.textLight,
    fontSize: 14,
    height: 1.6,
  );

  static const TextStyle caption = TextStyle(
    color: AppColors.textMuted,
    fontSize: 12,
  );

  static const TextStyle calendarDay = TextStyle(
    color: AppColors.textLight,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle calendarHeader = TextStyle(
    color: AppColors.textWhite,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle settingsItem = TextStyle(
    color: AppColors.textLight,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}
