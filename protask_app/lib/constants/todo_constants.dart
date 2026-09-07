import 'package:flutter/material.dart';

// constants specific to todos and todo realted widgets
class TodoConstants {
  // icons
  static const IconData deleteIcon = Icons.delete;

  // colors
  static const Color deleteColor = Colors.red;

  // spacing (row)
  static const EdgeInsets deleteIconPadding = EdgeInsets.only(right: 20);
  static const EdgeInsets todoTileBottomSpacing = EdgeInsets.only(bottom: 5);

  // other
  static const double dragElevation = 4;
}
