import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// constants for the basic app design
class AppThemeConstants {
  // text
  static const String appBarTitle = "proGres";

// colors - backgrounds
  static const Color backgroundColor = Color(0xff1e1e1e);
  static const Color todotileColor = Color(0xff4a4a4a);
  static const Color appBarColor = Color(0xff6b7874);
  static const Color surfaceColor = Color(0xff4a4a4a);
  static const Color popupColor = Color(0xff292929);

  // colors - text
  static const Color textColor = Color(0xfff7f8f9);
  static const Color hintTextColor = Color(0xffb0b1a2);

  // colors - ui
  static const Color buttonColor = Color(0xff657683);
  static const Color borderColor = Color(0xff6c7874);

  // colors - accent
  static const Color accentColor = Color(0xff845460);
  static const Color accentLightColor = Color(0xffead3cb);

  // text sizes
  static const double titleFontSize = 30;
  static const double subtitleFontSize = 15;
  static const double bodyFontSize = 15;

  // font weights
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

  
  // icons
  static const IconData todayIcon = Icons.wb_sunny_rounded;
  static const IconData calendarIcon = Icons.calendar_month;
  static const IconData accomplishmentIcon = Icons.check_circle_outline_rounded;
  static const IconData graphicIcon = Icons.auto_graph_outlined;
  static const IconData priorityIcon = Icons.flag;

  // icon labels
  static const String todayLabel = "Today";
  static const String calendarLabel = "Calendar";
  static const String accomplishmentLabel = "Accomplishments";
  static const String graphicLabel = "Goals";
  static const String priorityLabel = "Priorities";

  // Bottombaredges
  static const BorderRadius barBorderRadius = BorderRadius.only(
    topLeft: Radius.elliptical(15, 5),
    topRight: Radius.elliptical(15, 5),
  );
}
