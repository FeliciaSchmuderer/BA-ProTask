import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/timer_constants.dart';

class TimerFinishButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool fullWidth;

  const TimerFinishButton({
    super.key,
    required this.onPressed,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: TimerConstants.buttonHeight,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.check_rounded,
        ),
        label: const Text('Finish'),
        style: FilledButton.styleFrom(
          backgroundColor: AppThemeConstants.accentColor,
          foregroundColor: AppThemeConstants.textColor,
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
