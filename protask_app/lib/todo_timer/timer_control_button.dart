import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/timer_constants.dart';

class TimerControlButton extends StatelessWidget {
  final IconData? icon;
  final String label;

  final VoidCallback? onPressed;

  final bool fullWidth;
  final bool selected;

  const TimerControlButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.fullWidth = false,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: TimerConstants.buttonHeight,
      child: icon != null
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(label),
              style: _buttonStyle(),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: _buttonStyle(),
              child: Text(label),
            ),
    );
  }

  // creates button style based on the selected state
  ButtonStyle _buttonStyle() {
    return OutlinedButton.styleFrom(
      backgroundColor: selected
          ? AppThemeConstants.accentColor
          : AppThemeConstants.buttonColor,
      foregroundColor: AppThemeConstants.textColor,
      side: BorderSide(
        color: selected
            ? AppThemeConstants.accentLightColor
            : AppThemeConstants.borderColor,
        width: selected ? 2 : 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          TimerConstants.buttonRadius,
        ),
      ),
    );
  }
}
