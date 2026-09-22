import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';

class TimerClock extends StatelessWidget {
  final bool isRunning;

  const TimerClock({
    super.key,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // get available screen width
        final screenWidth = MediaQuery.of(context).size.width;

        // uses a smaller clock on smaller screens
        final clockSize = screenWidth < 400
            ? TimerConstants.smallClockSize
            : TimerConstants.clockSize;

        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 250,
          ),
          width: clockSize,
          height: clockSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: TimerConstants.clockBackground(),
          ),
          child: Icon(
            isRunning
                ? TimerConstants.timerIcon
                : TimerConstants.accessTimerIcon,
            size: clockSize * 0.45,
            color: TimerConstants.clockColor,
          ),
        );
      },
    );
  }
}
