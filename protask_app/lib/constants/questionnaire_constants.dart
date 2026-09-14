import 'package:flutter/material.dart';

class QuestionnaireConstants {
  // titles
  static const String todoHintText = 'Todo';
  static const String priorityTitle = 'Priority';
  static const String whenTitle = 'When?';
  static const String deadlineTitle = 'Deadline';
  static const String durationTitle = 'Duration';
  static const String pufferTitle = 'Puffer';
  static const String pufferText = 'You´/ve already planned 60% of your day';

  static const String createTodoText = 'Create';

  // general
  static const double buttonBorderRadius = 8;

  // (tags)
  static const double tagHorizonal = 4;
  static const double tagVertical = 2;
  static const double tagBorderRadius = 6;
  static const double tagFontSize = 12;

  // spacing
  static const double screenPadding = 24;
  static const double titleContentspacing = 35;
  static const double sectionSpacing = 40;
  static const double spacingSmall = 20;

  // fontweight
  static const FontWeight titleFontWeight = FontWeight.w900;
  static const FontWeight textFontWeight = FontWeight.normal;

  // buttons (general)
  static const double qButtonFontSize = 14;

  // todo input
  static const double todoTopSpacing = 32;
  static const double todoFontSize = 23;
  static const double todoHintFontSize = 18;
  static const FontWeight todoFontWeight = FontWeight.normal;

  // section titles
  static const double sectionTitleFontSize = 20;
  static const FontWeight sectionTitleFontWeight = FontWeight.w600;

  // priority
  static const double priorityFontSize = 18;

  static const double priorityButtonWidth = 60;
  static const double priorityButtonHeight = 60;

  static const double priorityButtonBorderRadius = 10;
  static const double priorityButtonBorderWidth = 1;
  static const double prioritySelectedButtonBorderWidth = 3;

  static const double prioritySpacing = 12;
  static const double removePriorityFontSize = 14;
  static const String removePriorityTitle = 'Remove Priority';

  // colors (priority)
  static const Color priorityAColor = Color(0xbff07587);
  static const Color priorityABorderColor = Color(0xffb07587);
  static const Color priorityBColor = Color(0xffefb09f);
  static const Color priorityBBorderColor = Color(0xffefb09f);
  static const Color priorityCColor = Color(0xffeff1b7);
  static const Color priorityCBorderColor = Color(0xffeff1b7);
  static const Color priorityDColor = Color(0xff5da8c6);
  static const Color priorityDBorderColor = Color(0xff5da8c6);

  // scheduled date
  static const double dateButtonWidth = 95;
  static const double dateButtonHeight = 65;
  static const double dateButtonBorderRadius = 13;
  static const double dateButtonBorderWidth = 1.5;

  static const double dateFontSize = 13;
  static const double dateTextSpacing = 4;

  static const String dateTextToday = 'Today';
  static const String dateTextTomorrow = 'Tomorrow';
  static const String dateTextPick = 'Pick Date';

  // deadline buttons
  static const String deadlineTextPick = 'Pick Deadline';
  static const String deadlineTimeTextPick = 'Pick Time';
  static const String removeDeadlineText = 'Remove Deadline';

  static const double deadlineButtonWidth = 120;
  static const double deadlineButtonHeight = 50;

  static const double deadlineButtonBorderRadius = 10;
  static const double deadlineButtonBorderWidth = 1;

  // duration
  static const String durationTextPick = 'Pick Duration';
  static const String removeDurationText = 'Remove Duration';

  // create button
  static const double createButtonHorizonal = 50;
  static const double createButtonVertical = 20;
  static const double createButtonRadius = 45;
  static const double createButtonFontSize = 18;
}
