import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/constants/timer_constants.dart';
import 'package:protask_app/helpers/app_duration_picker.dart';
import 'package:protask_app/todo_timer/timer_control_button.dart';

class TimerAdditionalTime extends StatefulWidget {
  final Function(int minutes) onSelected;
  final VoidCallback onBack;
  final VoidCallback onStart;

  const TimerAdditionalTime({
    super.key,
    required this.onSelected,
    required this.onBack,
    required this.onStart,
  });

  @override
  State<TimerAdditionalTime> createState() => _TimerAdditionalTimeState();
}

class _TimerAdditionalTimeState extends State<TimerAdditionalTime> {
  // currently selected additional time
  int? _selectedMinutes;
  // selects an additional duration
  void _selectTime(int minutes) {
    setState(() {
      _selectedMinutes = minutes;
    });

    // sends selected duration to the provider
    widget.onSelected(minutes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // back button
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: widget.onBack,
            icon: const Icon(TimerConstants.backIcon),
            color: AppThemeConstants.textColor,
            tooltip: TimerConstants.backText,
          ),
        ),

        const Text(
          TimerConstants.additionalTimeQuestion,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: TimerConstants.spacingMedium,
        ),
        Row(
          children: [
            Expanded(
              child: TimerControlButton(
                label: TimerConstants.additionalFiveMinutes,
                selected: _selectedMinutes == 5,
                onPressed: () => _selectTime(5),
              ),
            ),
            const SizedBox(
              width: TimerConstants.spacingSmall,
            ),
            Expanded(
              child: TimerControlButton(
                label: TimerConstants.additionalTenMinutes,
                selected: _selectedMinutes == 10,
                onPressed: () => _selectTime(10),
              ),
            ),
            const SizedBox(
              width: TimerConstants.spacingSmall,
            ),
            Expanded(
              child: TimerControlButton(
                label: TimerConstants.additionalFifteenMinutes,
                selected: _selectedMinutes == 15,
                onPressed: () => _selectTime(15),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: TimerConstants.spacingSmall,
        ),

        // second row of additional time buttons
        Row(
          children: [
            Expanded(
              child: TimerControlButton(
                label: TimerConstants.additionalTwentyMinutes,
                selected: _selectedMinutes == 20,
                onPressed: () => _selectTime(20),
              ),
            ),
            const SizedBox(
              width: TimerConstants.spacingSmall,
            ),
            Expanded(
              child: TimerControlButton(
                label: TimerConstants.additionalThirtyMinutes,
                selected: _selectedMinutes == 30,
                onPressed: () => _selectTime(30),
              ),
            ),
            const SizedBox(
              width: TimerConstants.spacingSmall,
            ),
            Expanded(
              child: TimerControlButton(
                label: TimerConstants.additionaCustomTime,
                selected: _selectedMinutes != null &&
                    ![5, 10, 15, 20, 30].contains(_selectedMinutes),
                onPressed: () async {
                  final selectedDuration =
                      await AppDurationPicker.selectDuration(
                    context,
                    _selectedMinutes,
                  );

                  if (selectedDuration == null || selectedDuration == 0) {
                    return;
                  }

                  _selectTime(selectedDuration);
                },
              ),
            ),
          ],
        ),

        const SizedBox(
          height: TimerConstants.spacingMedium,
        ),
        // start button
        TimerControlButton(
          icon: TimerConstants.startIcon,
          label: TimerConstants.startText,
          fullWidth: true,

          // diabled until a duration has been selected
          onPressed: _selectedMinutes == null ? null : widget.onStart,
        ),
      ],
    );
  }
}
