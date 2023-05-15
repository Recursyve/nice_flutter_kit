import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-hour-minute-control.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker-fragment-context.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker.widget.dart';

class HourControl extends StatelessWidget {
  const HourControl({
    required this.fragmentContext,
  });

  final TimePickerFragmentContext fragmentContext;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final bool alwaysUse24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String formattedHour = localizations.formatHour(
      fragmentContext.selectedTime,
      alwaysUse24HourFormat: alwaysUse24HourFormat,
    );

    TimeOfDay hoursFromSelected(int hoursToAdd) {
      if (fragmentContext.use24HourDials) {
        final int selectedHour = fragmentContext.selectedTime.hour;
        return fragmentContext.selectedTime.replacing(
          hour: (selectedHour + hoursToAdd) % TimeOfDay.hoursPerDay,
        );
      } else {
        // Cycle 1 through 12 without changing day period.
        final int periodOffset = fragmentContext.selectedTime.periodOffset;
        final int hours = fragmentContext.selectedTime.hourOfPeriod;
        return fragmentContext.selectedTime.replacing(
          hour: periodOffset + (hours + hoursToAdd) % TimeOfDay.hoursPerPeriod,
        );
      }
    }

    final TimeOfDay nextHour = hoursFromSelected(1);
    final String formattedNextHour = localizations.formatHour(
      nextHour,
      alwaysUse24HourFormat: alwaysUse24HourFormat,
    );
    final TimeOfDay previousHour = hoursFromSelected(-1);
    final String formattedPreviousHour = localizations.formatHour(
      previousHour,
      alwaysUse24HourFormat: alwaysUse24HourFormat,
    );

    return HourMinuteControl(
      isSelected: fragmentContext.mode == TimePickerMode.hour,
      text: formattedHour,
      onTap: Feedback.wrapForTap(() => fragmentContext.onModeChange(TimePickerMode.hour), context)!,
      onDoubleTap: fragmentContext.onHourDoubleTapped,
    );
  }
}
