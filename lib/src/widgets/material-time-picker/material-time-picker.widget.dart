import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-dial.widget.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker-header.widget.dart';

enum TimePickerMode { hour, minute }

const BorderRadius _kDefaultBorderRadius = BorderRadius.all(Radius.circular(4.0));
const ShapeBorder _kDefaultShape = RoundedRectangleBorder(borderRadius: _kDefaultBorderRadius);

class MaterialTimePickerWidget extends StatefulWidget {
  final TimeOfDay selectedTime;
  final void Function(TimeOfDay) onChange;

  static const double kTimePickerHeaderLandscapeWidth = 264.0;
  static const double kTimePickerHeaderControlHeight = 80.0;

  static const double kTimePickerWidthPortrait = 328.0;
  static const double kTimePickerWidthLandscape = 528.0;

  static const double kTimePickerHeightInput = 226.0;
  static const double kTimePickerHeightPortrait = 496.0;
  static const double kTimePickerHeightLandscape = 316.0;

  static const double kTimePickerHeightPortraitCollapsed = 484.0;
  static const double kTimePickerHeightLandscapeCollapsed = 304.0;

  static const BorderRadius kDefaultBorderRadius = BorderRadius.all(Radius.circular(4.0));
  static const ShapeBorder kDefaultShape = RoundedRectangleBorder(borderRadius: _kDefaultBorderRadius);

  const MaterialTimePickerWidget({
    required this.selectedTime,
    required this.onChange,
  });

  @override
  State<MaterialTimePickerWidget> createState() => _MaterialTimePickerWidgetState();
}

class _MaterialTimePickerWidgetState extends State<MaterialTimePickerWidget> {
  TimePickerMode timePickerMode = TimePickerMode.hour;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final header = DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: TimePickerHeader(
        selectedTime: widget.selectedTime,
        mode: timePickerMode,
        onModeChanged: _handleModeChanged,
        onChanged: _handleTimeChanged,
        use24HourDials: false,
        orientation: Orientation.portrait,
        onHourDoubleTapped: () {},
        onMinuteDoubleTapped: () {},
        helpText: '',
      ),
    );

    final dial = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Dial(
          mode: timePickerMode,
          use24HourDials: false,
          selectedTime: widget.selectedTime,
          onChanged: _handleTimeChanged,
          onHourSelected: _handleHourSelected,
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          header,
          dial,
        ],
      ),
    );
  }

  void _handleModeChanged(TimePickerMode mode) {
    setState(() {
      timePickerMode = mode;
    });
  }

  void _handleTimeChanged(TimeOfDay value) {
    widget.onChange(value);
  }

  void _handleHourSelected() {
    setState(() {
      timePickerMode = TimePickerMode.minute;
    });
  }
}
