import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';

class TimerConstants {
  // dialog
  static const double maxDialogWidth = 520;
  static const double maxDialogHeight = 700;

  static const double dialogHorizontalPadding = 20;
  static const double dialogVerticalPadding = 24;

  static const double dialogRadius = 28;

  // spacing general
  static const double spacingSmall = 8;
  static const double spacingMedium = 16;
  static const double spacingLarge = 24;
  static const double spacingExtraLarge = 32;

  // texts
  static const double todoTitleFontSize = 16;
  static const double countdwonFontSize = 52;
  static const double smallCountdownFontSize = 42;
  static const double statusFontSize = 14;

  // buttons
  static const double buttonHeight = 48;
  static const double buttonRadius = 14;

  // clock
  static const double clockSize = 120;
  static const double smallClockSize = 90;

  // colors
  static Color clockBackground() {
    return AppThemeConstants.buttonColor.withValues(alpha: 0.25);
  }

  static const Color clockColor = AppThemeConstants.accentLightColor;

  static Color secondaryTextColor = AppThemeConstants.hintTextColor;

  static const Color buttonTextColor = AppThemeConstants.textColor;

  static const Color countdownColor = AppThemeConstants.textColor;

  static const Color buttonColor = AppThemeConstants.buttonColor;

  static const Color finishColor = AppThemeConstants.accentColor;

  static const Color todotileColor = AppThemeConstants.hintTextColor;

  static const Color dialogBackgroundColor = AppThemeConstants.backgroundColor;

  static const Color statusColor = AppThemeConstants.accentColor;
}
