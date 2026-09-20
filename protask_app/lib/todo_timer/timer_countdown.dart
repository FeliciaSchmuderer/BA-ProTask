import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/timer_constants.dart';

class TimerCountdown extends StatelessWidget {
  final Duration duration;
  final double availableHeight;

  const TimerCountdown({
    super.key,
    required this.duration,
    required this.availableHeight,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    // uses a smaller font on smaller screens
    final fontSize = screenWidth < 400
        ? TimerConstants.smallCountdownFontSize
        : TimerConstants.countdwonFontSize;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        _formatDuration(duration),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: AppThemeConstants.subtitleFontWeight,
          letterSpacing: 2,
          color: TimerConstants.countdownColor,
        ),
      ),
    );
  }

  // converts duration into MM:SS
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final minutesText = minutes.toString().padLeft(2, '0');
    final secondsText = seconds.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutesText:$secondsText';
    }

    return '$minutesText:$secondsText';
  }
}
