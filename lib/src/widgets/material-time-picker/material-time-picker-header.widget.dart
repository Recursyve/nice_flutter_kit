import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-day-period-control.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-hour-control.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-minute-control.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-string-fragment.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker-fragment-context.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker.widget.dart';

class TimePickerHeader extends StatelessWidget {
  const TimePickerHeader({
    required this.selectedTime,
    required this.mode,
    required this.orientation,
    required this.onModeChanged,
    required this.onChanged,
    required this.onHourDoubleTapped,
    required this.onMinuteDoubleTapped,
    required this.use24HourDials,
    required this.helpText,
  })  : assert(selectedTime != null),
        assert(mode != null),
        assert(orientation != null),
        assert(use24HourDials != null);

  final TimeOfDay selectedTime;
  final TimePickerMode mode;
  final Orientation orientation;
  final ValueChanged<TimePickerMode> onModeChanged;
  final ValueChanged<TimeOfDay> onChanged;
  final GestureTapCallback onHourDoubleTapped;
  final GestureTapCallback onMinuteDoubleTapped;
  final bool use24HourDials;
  final String? helpText;

  void _handleChangeMode(TimePickerMode value) {
    if (value != mode) {
      onModeChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final ThemeData themeData = Theme.of(context);
    const TimeOfDayFormat timeOfDayFormat = TimeOfDayFormat.a_space_h_colon_mm;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String timePickerDialHelpText = themeData.useMaterial3
        ? localizations.timePickerDialHelpText
        : localizations.timePickerDialHelpText.toUpperCase();

    final TimePickerFragmentContext fragmentContext = TimePickerFragmentContext(
      selectedTime: selectedTime,
      mode: mode,
      onTimeChange: onChanged,
      onModeChange: _handleChangeMode,
      onHourDoubleTapped: onHourDoubleTapped,
      onMinuteDoubleTapped: onMinuteDoubleTapped,
      use24HourDials: use24HourDials,
    );

    final EdgeInsets padding;
    double? width;
    final Widget controls;

    switch (orientation) {
      case Orientation.portrait:
        // Keep width null because in portrait we don't cap the width.
        padding = const EdgeInsets.symmetric(horizontal: 24.0);
        controls = Column(
          children: <Widget>[
            SizedBox(
              height: kMinInteractiveDimension * 2,
              child: Row(
                children: <Widget>[
                  if (!use24HourDials && timeOfDayFormat != TimeOfDayFormat.a_space_h_colon_mm) ...<Widget>[
                    DayPeriodControl(
                      selectedTime: selectedTime,
                      orientation: orientation,
                      onChanged: onChanged,
                    ),
                    const SizedBox(width: 12.0),
                  ],
                  Expanded(
                    child: Row(
                      // Hour/minutes should not change positions in RTL locales.
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Expanded(child: HourControl(fragmentContext: fragmentContext)),
                        const StringFragment(timeOfDayFormat: timeOfDayFormat),
                        Expanded(child: MinuteControl(fragmentContext: fragmentContext)),
                      ],
                    ),
                  ),
                  if (!use24HourDials && timeOfDayFormat == TimeOfDayFormat.a_space_h_colon_mm) ...<Widget>[
                    const SizedBox(width: 12.0),
                    DayPeriodControl(
                      selectedTime: selectedTime,
                      orientation: orientation,
                      onChanged: onChanged,
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
        break;
      case Orientation.landscape:
        width = MaterialTimePickerWidget.kTimePickerHeaderLandscapeWidth;
        padding = const EdgeInsets.symmetric(horizontal: 24.0);
        controls = Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!use24HourDials && timeOfDayFormat == TimeOfDayFormat.a_space_h_colon_mm)
                DayPeriodControl(
                  selectedTime: selectedTime,
                  orientation: orientation,
                  onChanged: onChanged,
                ),
              SizedBox(
                height: kMinInteractiveDimension * 2,
                child: Row(
                  // Hour/minutes should not change positions in RTL locales.
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Expanded(child: HourControl(fragmentContext: fragmentContext)),
                    StringFragment(timeOfDayFormat: timeOfDayFormat),
                    Expanded(child: MinuteControl(fragmentContext: fragmentContext)),
                  ],
                ),
              ),
              if (!use24HourDials && timeOfDayFormat != TimeOfDayFormat.a_space_h_colon_mm)
                DayPeriodControl(
                  selectedTime: selectedTime,
                  orientation: orientation,
                  onChanged: onChanged,
                ),
            ],
          ),
        );
        break;
    }

    return Container(
      width: width,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16.0),
          Text(
            helpText ?? timePickerDialHelpText,
            style: TimePickerTheme.of(context).helpTextStyle ?? themeData.textTheme.labelSmall,
          ),
          controls,
        ],
      ),
    );
  }
}
