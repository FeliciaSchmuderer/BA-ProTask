import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';

class TimerControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;

  const TimerControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: TimerConstants.buttonHeight,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        label: Text(label),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              TimerConstants.buttonRadius,
            ),
          ),
        ),
      ),
    );
  }
}
