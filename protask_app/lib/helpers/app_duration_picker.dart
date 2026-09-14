import 'package:flutter/cupertino.dart';
import 'package:protask_app/constants/app_theme_constants.dart';

class AppDurationPicker {
  static Future<int?> selectDuration(
    BuildContext context,
    int? selectedDuration,
  ) async {
    final initialDuration = selectedDuration ?? 60;

    int selectedHours = initialDuration ~/ 60;
    int selectedMinutes = initialDuration % 60;

    int pickedDuration = initialDuration;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 216,
          color: AppThemeConstants.backgroundColor,
          child: SafeArea(
            top: false,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(
                  pickerTextStyle: TextStyle(
                    color: AppThemeConstants.textColor,
                    fontSize: 22,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 32,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedHours,
                      ),
                      onSelectedItemChanged: (int value) {
                        selectedHours = value;
                        pickedDuration = selectedHours * 60 + selectedMinutes;
                      },
                      children: List.generate(
                        24,
                        (index) => Center(
                          child: Text('$index h'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 32,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedMinutes,
                      ),
                      onSelectedItemChanged: (int value) {
                        selectedMinutes = value;
                        pickedDuration = selectedHours * 60 + selectedMinutes;
                      },
                      children: List.generate(
                        60,
                        (index) => Center(
                          child: Text('$index min'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return pickedDuration;
  }
}
