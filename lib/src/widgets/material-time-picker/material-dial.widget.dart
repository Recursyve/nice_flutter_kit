import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker.widget.dart';

const Duration _kDialAnimateDuration = Duration(milliseconds: 200);
const double _kTwoPi = 2 * math.pi;

class Dial extends StatefulWidget {
  const Dial({
    required this.selectedTime,
    required this.mode,
    required this.use24HourDials,
    required this.onChanged,
    required this.onHourSelected,
  })  : assert(selectedTime != null),
        assert(mode != null),
        assert(use24HourDials != null);

  final TimeOfDay selectedTime;
  final TimePickerMode mode;
  final bool use24HourDials;
  final ValueChanged<TimeOfDay>? onChanged;
  final VoidCallback? onHourSelected;

  @override
  _DialState createState() => _DialState();
}

class _DialState extends State<Dial> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _thetaController = AnimationController(
      duration: _kDialAnimateDuration,
      vsync: this,
    );
    _thetaTween = Tween<double>(begin: _getThetaForTime(widget.selectedTime));
    _theta = _thetaController.drive(CurveTween(curve: standardEasing)).drive(_thetaTween)
      ..addListener(() => setState(() {
            /* _theta.value has changed */
          }));
  }

  late ThemeData themeData;
  late MaterialLocalizations localizations;
  late MediaQueryData media;
  DialPainter? painter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMediaQuery(context));
    themeData = Theme.of(context);
    localizations = MaterialLocalizations.of(context);
    media = MediaQuery.of(context);
  }

  @override
  void didUpdateWidget(Dial oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mode != oldWidget.mode || widget.selectedTime != oldWidget.selectedTime) {
      if (!_dragging) {
        _animateTo(_getThetaForTime(widget.selectedTime));
      }
    }
  }

  @override
  void dispose() {
    _thetaController.dispose();
    painter?.dispose();
    super.dispose();
  }

  late Tween<double> _thetaTween;
  late Animation<double> _theta;
  late AnimationController _thetaController;
  bool _dragging = false;

  static double _nearest(double target, double a, double b) {
    return ((target - a).abs() < (target - b).abs()) ? a : b;
  }

  void _animateTo(double targetTheta) {
    final double currentTheta = _theta.value;
    double beginTheta = _nearest(targetTheta, currentTheta, currentTheta + _kTwoPi);
    beginTheta = _nearest(targetTheta, beginTheta, currentTheta - _kTwoPi);
    _thetaTween
      ..begin = beginTheta
      ..end = targetTheta;
    _thetaController
      ..value = 0.0
      ..forward();
  }

  double _getThetaForTime(TimeOfDay time) {
    final int hoursFactor = widget.use24HourDials ? TimeOfDay.hoursPerDay : TimeOfDay.hoursPerPeriod;
    final double fraction = widget.mode == TimePickerMode.hour
        ? (time.hour / hoursFactor) % hoursFactor
        : (time.minute / TimeOfDay.minutesPerHour) % TimeOfDay.minutesPerHour;
    return (math.pi / 2.0 - fraction * _kTwoPi) % _kTwoPi;
  }

  TimeOfDay _getTimeForTheta(double theta, {bool roundMinutes = false}) {
    final double fraction = (0.25 - (theta % _kTwoPi) / _kTwoPi) % 1.0;
    if (widget.mode == TimePickerMode.hour) {
      int newHour;
      if (widget.use24HourDials) {
        newHour = (fraction * TimeOfDay.hoursPerDay).round() % TimeOfDay.hoursPerDay;
      } else {
        newHour = (fraction * TimeOfDay.hoursPerPeriod).round() % TimeOfDay.hoursPerPeriod;
        newHour = newHour + widget.selectedTime.periodOffset;
      }
      return widget.selectedTime.replacing(hour: newHour);
    } else {
      int minute = (fraction * TimeOfDay.minutesPerHour).round() % TimeOfDay.minutesPerHour;
      if (roundMinutes) {
        // Round the minutes to nearest 5 minute interval.
        minute = ((minute + 2) ~/ 5) * 5 % TimeOfDay.minutesPerHour;
      }
      return widget.selectedTime.replacing(minute: minute);
    }
  }

  TimeOfDay _notifyOnChangedIfNeeded({bool roundMinutes = false}) {
    final TimeOfDay current = _getTimeForTheta(_theta.value, roundMinutes: roundMinutes);
    if (widget.onChanged == null) {
      return current;
    }
    if (current != widget.selectedTime) {
      widget.onChanged!(current);
    }
    return current;
  }

  void _updateThetaForPan({bool roundMinutes = false}) {
    setState(() {
      final Offset offset = _position! - _center!;
      double angle = (math.atan2(offset.dx, offset.dy) - math.pi / 2.0) % _kTwoPi;
      if (roundMinutes) {
        angle = _getThetaForTime(_getTimeForTheta(angle, roundMinutes: roundMinutes));
      }
      _thetaTween
        ..begin = angle
        ..end = angle; // The controller doesn't animate during the pan gesture.
    });
  }

  Offset? _position;
  Offset? _center;

  void _handlePanStart(DragStartDetails details) {
    assert(!_dragging);
    _dragging = true;
    final RenderBox box = context.findRenderObject()! as RenderBox;
    _position = box.globalToLocal(details.globalPosition);
    _center = box.size.center(Offset.zero);
    _updateThetaForPan();
    _notifyOnChangedIfNeeded();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    _position = _position! + details.delta;
    _updateThetaForPan();
    _notifyOnChangedIfNeeded();
  }

  void _handlePanEnd(DragEndDetails details) {
    assert(_dragging);
    _dragging = false;
    _position = null;
    _center = null;
    _animateTo(_getThetaForTime(widget.selectedTime));
    if (widget.mode == TimePickerMode.hour) {
      widget.onHourSelected?.call();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    final RenderBox box = context.findRenderObject()! as RenderBox;
    _position = box.globalToLocal(details.globalPosition);
    _center = box.size.center(Offset.zero);
    _updateThetaForPan(roundMinutes: true);
    final TimeOfDay newTime = _notifyOnChangedIfNeeded(roundMinutes: true);
    _animateTo(_getThetaForTime(_getTimeForTheta(_theta.value, roundMinutes: true)));
    _dragging = false;
    _position = null;
    _center = null;
  }

  void _selectHour(int hour) {
    final TimeOfDay time;
    if (widget.mode == TimePickerMode.hour && widget.use24HourDials) {
      time = TimeOfDay(hour: hour, minute: widget.selectedTime.minute);
    } else {
      if (widget.selectedTime.period == DayPeriod.am) {
        time = TimeOfDay(hour: hour, minute: widget.selectedTime.minute);
      } else {
        time = TimeOfDay(hour: hour + TimeOfDay.hoursPerPeriod, minute: widget.selectedTime.minute);
      }
    }
    final double angle = _getThetaForTime(time);
    _thetaTween
      ..begin = angle
      ..end = angle;
    _notifyOnChangedIfNeeded();
  }

  void _selectMinute(int minute) {
    final TimeOfDay time = TimeOfDay(
      hour: widget.selectedTime.hour,
      minute: minute,
    );
    final double angle = _getThetaForTime(time);
    _thetaTween
      ..begin = angle
      ..end = angle;
    _notifyOnChangedIfNeeded();
  }

  static const List<TimeOfDay> _amHours = <TimeOfDay>[
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 1, minute: 0),
    TimeOfDay(hour: 2, minute: 0),
    TimeOfDay(hour: 3, minute: 0),
    TimeOfDay(hour: 4, minute: 0),
    TimeOfDay(hour: 5, minute: 0),
    TimeOfDay(hour: 6, minute: 0),
    TimeOfDay(hour: 7, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 0),
  ];

  static const List<TimeOfDay> _twentyFourHours = <TimeOfDay>[
    TimeOfDay(hour: 0, minute: 0),
    TimeOfDay(hour: 2, minute: 0),
    TimeOfDay(hour: 4, minute: 0),
    TimeOfDay(hour: 6, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 16, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 20, minute: 0),
    TimeOfDay(hour: 22, minute: 0),
  ];

  _TappableLabel _buildTappableLabel(TextTheme textTheme, Color color, int value, String label, VoidCallback onTap) {
    final TextStyle style = textTheme.bodyLarge!.copyWith(color: color);
    final double labelScaleFactor = math.min(MediaQuery.of(context).textScaleFactor, 2.0);
    return _TappableLabel(
      value: value,
      painter: TextPainter(
        text: TextSpan(style: style, text: label),
        textDirection: TextDirection.ltr,
        textScaleFactor: labelScaleFactor,
      )..layout(),
      onTap: onTap,
    );
  }

  List<_TappableLabel> _build24HourRing(TextTheme textTheme, Color color) => <_TappableLabel>[
        for (final TimeOfDay timeOfDay in _twentyFourHours)
          _buildTappableLabel(
            textTheme,
            color,
            timeOfDay.hour,
            localizations.formatHour(timeOfDay, alwaysUse24HourFormat: media.alwaysUse24HourFormat),
            () {
              _selectHour(timeOfDay.hour);
            },
          ),
      ];

  List<_TappableLabel> _build12HourRing(TextTheme textTheme, Color color) => <_TappableLabel>[
        for (final TimeOfDay timeOfDay in _amHours)
          _buildTappableLabel(
            textTheme,
            color,
            timeOfDay.hour,
            localizations.formatHour(timeOfDay, alwaysUse24HourFormat: media.alwaysUse24HourFormat),
            () {
              _selectHour(timeOfDay.hour);
            },
          ),
      ];

  List<_TappableLabel> _buildMinutes(TextTheme textTheme, Color color) {
    const List<TimeOfDay> minuteMarkerValues = <TimeOfDay>[
      TimeOfDay(hour: 0, minute: 0),
      TimeOfDay(hour: 0, minute: 5),
      TimeOfDay(hour: 0, minute: 10),
      TimeOfDay(hour: 0, minute: 15),
      TimeOfDay(hour: 0, minute: 20),
      TimeOfDay(hour: 0, minute: 25),
      TimeOfDay(hour: 0, minute: 30),
      TimeOfDay(hour: 0, minute: 35),
      TimeOfDay(hour: 0, minute: 40),
      TimeOfDay(hour: 0, minute: 45),
      TimeOfDay(hour: 0, minute: 50),
      TimeOfDay(hour: 0, minute: 55),
    ];

    return <_TappableLabel>[
      for (final TimeOfDay timeOfDay in minuteMarkerValues)
        _buildTappableLabel(
          textTheme,
          color,
          timeOfDay.minute,
          localizations.formatMinute(timeOfDay),
          () {
            _selectMinute(timeOfDay.minute);
          },
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TimePickerThemeData pickerTheme = TimePickerTheme.of(context);
    final Color backgroundColor =
        pickerTheme.dialBackgroundColor ?? themeData.colorScheme.onBackground.withOpacity(0.12);
    final Color accentColor = pickerTheme.dialHandColor ?? themeData.colorScheme.primary;
    final Color primaryLabelColor = MaterialStateProperty.resolveAs(pickerTheme.dialTextColor, <MaterialState>{}) ??
        themeData.colorScheme.onSurface;
    final Color secondaryLabelColor =
        MaterialStateProperty.resolveAs(pickerTheme.dialTextColor, <MaterialState>{MaterialState.selected}) ??
            themeData.colorScheme.onPrimary;
    List<_TappableLabel> primaryLabels;
    List<_TappableLabel> secondaryLabels;
    final int selectedDialValue;
    switch (widget.mode) {
      case TimePickerMode.hour:
        if (widget.use24HourDials) {
          selectedDialValue = widget.selectedTime.hour;
          primaryLabels = _build24HourRing(theme.textTheme, primaryLabelColor);
          secondaryLabels = _build24HourRing(theme.textTheme, secondaryLabelColor);
        } else {
          selectedDialValue = widget.selectedTime.hourOfPeriod;
          primaryLabels = _build12HourRing(theme.textTheme, primaryLabelColor);
          secondaryLabels = _build12HourRing(theme.textTheme, secondaryLabelColor);
        }
        break;
      case TimePickerMode.minute:
        selectedDialValue = widget.selectedTime.minute;
        primaryLabels = _buildMinutes(theme.textTheme, primaryLabelColor);
        secondaryLabels = _buildMinutes(theme.textTheme, secondaryLabelColor);
        break;
    }

    painter?.dispose();
    painter = DialPainter(
      selectedValue: selectedDialValue,
      primaryLabels: primaryLabels,
      secondaryLabels: secondaryLabels,
      backgroundColor: backgroundColor,
      accentColor: accentColor,
      dotColor: theme.colorScheme.surface,
      theta: _theta.value,
      textDirection: Directionality.of(context),
    );

    return GestureDetector(
      excludeFromSemantics: true,
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      onTapUp: _handleTapUp,
      child: CustomPaint(
        key: const ValueKey<String>('time-picker-dial'),
        painter: painter,
      ),
    );
  }
}

class DialPainter extends CustomPainter {
  DialPainter({
    required this.primaryLabels,
    required this.secondaryLabels,
    required this.backgroundColor,
    required this.accentColor,
    required this.dotColor,
    required this.theta,
    required this.textDirection,
    required this.selectedValue,
  }) : super(repaint: PaintingBinding.instance.systemFonts);

  final List<_TappableLabel> primaryLabels;
  final List<_TappableLabel> secondaryLabels;
  final Color backgroundColor;
  final Color accentColor;
  final Color dotColor;
  final double theta;
  final TextDirection textDirection;
  final int selectedValue;

  static const double _labelPadding = 28.0;

  void dispose() {
    for (final _TappableLabel label in primaryLabels) {
      label.painter.dispose();
    }
    for (final _TappableLabel label in secondaryLabels) {
      label.painter.dispose();
    }
    primaryLabels.clear();
    secondaryLabels.clear();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.shortestSide / 2.0;
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final Offset centerPoint = center;
    canvas.drawCircle(centerPoint, radius, Paint()..color = backgroundColor);

    final double labelRadius = radius - _labelPadding;
    Offset getOffsetForTheta(double theta) {
      return center + Offset(labelRadius * math.cos(theta), -labelRadius * math.sin(theta));
    }

    void paintLabels(List<_TappableLabel>? labels) {
      if (labels == null) {
        return;
      }
      final double labelThetaIncrement = -_kTwoPi / labels.length;
      double labelTheta = math.pi / 2.0;

      for (final _TappableLabel label in labels) {
        final TextPainter labelPainter = label.painter;
        final Offset labelOffset = Offset(-labelPainter.width / 2.0, -labelPainter.height / 2.0);
        labelPainter.paint(canvas, getOffsetForTheta(labelTheta) + labelOffset);
        labelTheta += labelThetaIncrement;
      }
    }

    paintLabels(primaryLabels);

    final Paint selectorPaint = Paint()..color = accentColor;
    final Offset focusedPoint = getOffsetForTheta(theta);
    const double focusedRadius = _labelPadding - 4.0;
    canvas.drawCircle(centerPoint, 4.0, selectorPaint);
    canvas.drawCircle(focusedPoint, focusedRadius, selectorPaint);
    selectorPaint.strokeWidth = 2.0;
    canvas.drawLine(centerPoint, focusedPoint, selectorPaint);

    // Add a dot inside the selector but only when it isn't over the labels.
    // This checks that the selector's theta is between two labels. A remainder
    // between 0.1 and 0.45 indicates that the selector is roughly not above any
    // labels. The values were derived by manually testing the dial.
    final double labelThetaIncrement = -_kTwoPi / primaryLabels.length;
    if (theta % labelThetaIncrement > 0.1 && theta % labelThetaIncrement < 0.45) {
      canvas.drawCircle(focusedPoint, 2.0, selectorPaint..color = dotColor);
    }

    final Rect focusedRect = Rect.fromCircle(
      center: focusedPoint,
      radius: focusedRadius,
    );
    canvas
      ..save()
      ..clipPath(Path()..addOval(focusedRect));
    paintLabels(secondaryLabels);
    canvas.restore();
  }

  @override
  bool shouldRepaint(DialPainter oldPainter) {
    return oldPainter.primaryLabels != primaryLabels ||
        oldPainter.secondaryLabels != secondaryLabels ||
        oldPainter.backgroundColor != backgroundColor ||
        oldPainter.accentColor != accentColor ||
        oldPainter.theta != theta;
  }
}

class _TappableLabel {
  _TappableLabel({
    required this.value,
    required this.painter,
    required this.onTap,
  });

  /// The value this label is displaying.
  final int value;

  /// Paints the text of the label.
  final TextPainter painter;

  /// Called when a tap gesture is detected on the label.
  final VoidCallback onTap;
}
