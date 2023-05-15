import 'package:flutter/material.dart';

class StringFragment extends StatelessWidget {
  const StringFragment({
    required this.timeOfDayFormat,
  });

  final TimeOfDayFormat timeOfDayFormat;

  String _stringFragmentValue(TimeOfDayFormat timeOfDayFormat) {
    switch (timeOfDayFormat) {
      case TimeOfDayFormat.h_colon_mm_space_a:
      case TimeOfDayFormat.a_space_h_colon_mm:
      case TimeOfDayFormat.H_colon_mm:
      case TimeOfDayFormat.HH_colon_mm:
        return ':';
      case TimeOfDayFormat.HH_dot_mm:
        return '.';
      case TimeOfDayFormat.frenchCanadian:
        return 'h';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TimePickerThemeData timePickerTheme = TimePickerTheme.of(context);
    final TextStyle hourMinuteStyle = timePickerTheme.hourMinuteTextStyle ?? theme.textTheme.displayMedium!;
    final Color textColor = timePickerTheme.hourMinuteTextColor ?? theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Center(
        child: Text(
          _stringFragmentValue(timeOfDayFormat),
          style: hourMinuteStyle.apply(color: MaterialStateProperty.resolveAs(textColor, <MaterialState>{})),
          textScaleFactor: 1.0,
        ),
      ),
    );
  }
}
