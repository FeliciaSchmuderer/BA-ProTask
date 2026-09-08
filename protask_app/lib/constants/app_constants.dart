import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// general constants used throughout the entire app
class AppConstants {
  // text sizes
  static const double titleFontSize = 30;
  static const double subtitleFontSize = 15;
  static const double bodyFontSize = 15;

  // fint weights
  static const FontWeight titleFontWeight = FontWeight.bold;
  static const FontWeight subtitleFontWeight = FontWeight.normal;

  // spacing
  static const double spacingMedium = 20;
  static const double spacingSmall = 5;
  static const double spacingMini = 3;

  // general layout
  static const EdgeInsets screenPadding = EdgeInsets.all(20);

  // current date
  static String get currentDate =>
      DateFormat('EEEE, dd.MM.yyyy', 'de_DE').format(DateTime.now());

  // input field
  static const double inputFieldWidthFactor = 0.9;
  static const double inputFieldHeight = 45;
  static const BorderRadius inputFieldBorderRadius =
      BorderRadius.all(Radius.circular(25));
  static const double inputFieldSpacing = 10;

  // colors
  static final Color inputFieldColor = Colors.grey[350]!;

  // icons
  static const IconData addTodoIcon = Icons.send_rounded;
  static const IconData addIcon = Icons.add;
  static const IconData questionnaireIcon = Icons.auto_awesome;

  // icon colors
  static const Color iconColor = Colors.white;
}
