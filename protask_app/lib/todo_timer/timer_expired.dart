import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/timer_constants.dart';

class TimerExpired extends StatelessWidget {
  final VoidCallback onMoreTime;
  final VoidCallback onFinish;

  const TimerExpired({
    super.key,
    required this.onMoreTime,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expired message
        const Text(
          TimerConstants.expiredText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TimerConstants.messageFontSize,
            fontWeight: TimerConstants.messageFontWeight,
            color: AppThemeConstants.textColor,
          ),
        ),

        const SizedBox(
          height: TimerConstants.spacingSmall,
        ),

        // More Time + Finish button
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onMoreTime,
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppThemeConstants.buttonColor,
                  foregroundColor: AppThemeConstants.textColor,
                  side: const BorderSide(
                    color: AppThemeConstants.borderColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      TimerConstants.buttonRadius,
                    ),
                  ),
                ),
                child: const Text(TimerConstants.moreTimeText),
              ),
            ),
            const SizedBox(
              width: TimerConstants.spacingSmall,
            ),
            Expanded(
              child: FilledButton(
                onPressed: onFinish,
                style: FilledButton.styleFrom(
                  backgroundColor: AppThemeConstants.accentColor,
                  foregroundColor: AppThemeConstants.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      TimerConstants.buttonRadius,
                    ),
                  ),
                ),
                child: const Text(TimerConstants.finishText),
              ),
            ),
          ],
        )
      ],
    );
  }
}
