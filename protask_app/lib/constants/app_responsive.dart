import 'package:flutter/material.dart';

// central helper for responsive values across the app
class AppResponsive {
  static double factor(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return (width / 400).clamp(0.75, 1.0);
  }

  static double size(
    BuildContext context,
    double baseSize,
  ) {
    return baseSize * factor(context);
  }
}
