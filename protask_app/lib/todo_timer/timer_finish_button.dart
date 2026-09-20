import 'package:flutter/material.dart';
import 'package:protask_app/constants/timer_constants.dart';

class TimerFinishButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TimerFinishButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: TimerConstants.buttonHeight,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.check_rounded,
        ),
        label: const Text('Finish'),
        style: FilledButton.styleFrom(
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
