import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-hour-minute-control.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker-fragment-context.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker.widget.dart';

class MinuteControl extends StatelessWidget {
  const MinuteControl({
    required this.fragmentContext,
  });

  final TimePickerFragmentContext fragmentContext;

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String formattedMinute = localizations.formatMinute(fragmentContext.selectedTime);
    final TimeOfDay nextMinute = fragmentContext.selectedTime.replacing(
      minute: (fragmentContext.selectedTime.minute + 1) % TimeOfDay.minutesPerHour,
    );
    final String formattedNextMinute = localizations.formatMinute(nextMinute);
    final TimeOfDay previousMinute = fragmentContext.selectedTime.replacing(
      minute: (fragmentContext.selectedTime.minute - 1) % TimeOfDay.minutesPerHour,
    );
    final String formattedPreviousMinute = localizations.formatMinute(previousMinute);

    return Semantics(
      excludeSemantics: true,
      value: '${localizations.timePickerMinuteModeAnnouncement} $formattedMinute',
      increasedValue: formattedNextMinute,
      onIncrease: () {
        fragmentContext.onTimeChange(nextMinute);
      },
      decreasedValue: formattedPreviousMinute,
      onDecrease: () {
        fragmentContext.onTimeChange(previousMinute);
      },
      child: HourMinuteControl(
        isSelected: fragmentContext.mode == TimePickerMode.minute,
        text: formattedMinute,
        onTap: Feedback.wrapForTap(() => fragmentContext.onModeChange(TimePickerMode.minute), context)!,
        onDoubleTap: fragmentContext.onMinuteDoubleTapped,
      ),
    );
  }
}
