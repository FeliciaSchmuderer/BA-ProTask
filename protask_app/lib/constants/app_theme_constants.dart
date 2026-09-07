import 'package:flutter/material.dart';

// constants for the basic app design
class AppThemeConstants {
  // text
  static const String appBarTitle = "Protask";

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

  // colors
  static const Color bottomNavigationBarColor = Colors.blueGrey;
  static const Color selectedItemColor = Colors.white;

  // Bottombaredges
  static const BorderRadius barBorderRadius = BorderRadius.only(
    topLeft: Radius.elliptical(15, 5),
    topRight: Radius.elliptical(15, 5),
  );
}
