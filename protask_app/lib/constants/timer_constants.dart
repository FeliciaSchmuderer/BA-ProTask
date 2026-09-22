import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';

class TimerConstants {
  // texts
  static const String additionalTimeQuestion = 'How much more time do you nee?';
  static const String backText = 'Back';
  static const String startText = 'Start';
  static const String pauseText = 'Pause';
  static const String stopText = 'Stop';
  static const String finishText = 'Finish';
  static const String moreTimeText = 'More Time';
  static const String expiredText = 'Time expired!';

  // additional time options
  static const String additionalFiveMinutes = '+5';
  static const String additionalTenMinutes = '+10';
  static const String additionalFifteenMinutes = '+15';
  static const String additionalTwentyMinutes = '+20';
  static const String additionalThirtyMinutes = '+30';
  static const String additionaCustomTime = 'Pick';

  static const List<int> additionalTimeOptions = [
    5,
    10,
    15,
    20,
    30,
  ];

  // Timer status texts
  static const String readyStatus = 'Ready';
  static const String runningStatus = 'Timer is running';
  static const String pausedStatus = 'Paused';
  static const String stoppedStatus = 'Stopped';
  static const String finishStatus = 'Finished';
  static const String expiredStatus = 'Time expired';

  // fontsizes
  static const double messageFontSize = 20;
  static const double todoTitleFontSize = 16;
  static const double countdwonFontSize = 52;
  static const double smallCountdownFontSize = 42;
  static const double statusFontSize = 14;
  static const FontWeight messageFontWeight = FontWeight.bold;

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

  static const double countdownLetterSpacing = 2;

  // buttons
  static const double buttonHeight = 48;
  static const double buttonRadius = 14;

  // clock
  static const double clockSize = 120;
  static const double smallClockSize = 90;

  // clock icons
  static const IconData timerIcon = Icons.timer_rounded;
  static const IconData accessTimerIcon = Icons.access_time_rounded;

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

  // icons
  static const IconData backIcon = Icons.arrow_back_ios;
  static const IconData startIcon = Icons.play_arrow;
  static const IconData pauseIcon = Icons.pause_rounded;
  static const IconData stopIcon = Icons.stop_rounded;
  static const IconData finishIcon = Icons.check_rounded;
}
