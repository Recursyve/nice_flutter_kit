import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker.widget.dart';

class TimePickerFragmentContext {
  const TimePickerFragmentContext({
    required this.selectedTime,
    required this.mode,
    required this.onTimeChange,
    required this.onModeChange,
    required this.onHourDoubleTapped,
    required this.onMinuteDoubleTapped,
    required this.use24HourDials,
  })  : assert(selectedTime != null),
        assert(mode != null),
        assert(onTimeChange != null),
        assert(onModeChange != null),
        assert(use24HourDials != null);

  final TimeOfDay selectedTime;
  final TimePickerMode mode;
  final ValueChanged<TimeOfDay> onTimeChange;
  final ValueChanged<TimePickerMode> onModeChange;
  final GestureTapCallback onHourDoubleTapped;
  final GestureTapCallback onMinuteDoubleTapped;
  final bool use24HourDials;
}
