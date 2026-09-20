import 'package:flutter/material.dart';

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
  static Color clockBackground(BuildContext context) {
    return Theme.of(context).colorScheme.primary.withValues(alpha: 0.10);
  }

  static Color clockColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color secondaryTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55);
  }
}
