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
  static const double screenPadding = 24;
  static const double titleContentspacing = 35;
  static const double sectionSpacing = 40;

  static const FontWeight titleFontWeight = FontWeight.w900;
  static const FontWeight textFontWeight = FontWeight.w600;

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

  // colors (priority)
  static const Color priorityAColor = Color.fromARGB(255, 250, 116, 130);
  static const Color priorityABorderColor = Color.fromARGB(255, 190, 18, 35);
  static const Color priorityBColor = Color.fromARGB(255, 249, 159, 107);
  static const Color priorityBBorderColor = Color.fromARGB(255, 235, 124, 50);
  static const Color priorityCColor = Color.fromARGB(255, 250, 228, 116);
  static const Color priorityCBorderColor = Color.fromARGB(255, 246, 202, 57);
  static const Color priorityDColor = Color.fromARGB(255, 144, 186, 246);
  static const Color priorityDBorderColor = Color.fromARGB(255, 72, 140, 228);

  // scheduled date
  static const double dateButtonWidth = 95;
  static const double dateButtonHeight = 65;
  static const double dateButtonBorderRadius = 13;
  static const double dateButtonBorderWidth = 1.5;

  static const double dateTitleFontSize = 14;
  static const double dateFontSize = 13;
  static const double dateTextSpacing = 4;

  static const String dateTextToday = 'Today';
  static const String dateTextTomorrow = 'Tomorrow';
  static const String dateTextPick = 'Pick Date';

  // colors (date button)
  static const Color dateSelectedColor = Colors.black87;
  static const Color dateNotSelectedColor = Colors.grey;

  static const Color dateSelectedTextColor = Colors.white;
  static const Color dateNotSelectedTextColor = Colors.black;

  static const Color dateNotSelectedBorderColor = Colors.grey;
}
