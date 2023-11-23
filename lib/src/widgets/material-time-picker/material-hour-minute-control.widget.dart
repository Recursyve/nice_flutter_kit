import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-time-picker.widget.dart';

class HourMinuteControl extends StatelessWidget {
  const HourMinuteControl({
    required this.text,
    required this.onTap,
    required this.onDoubleTap,
    required this.isSelected,
  })  : assert(text != null),
        assert(onTap != null),
        assert(isSelected != null);

  final String text;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TimePickerThemeData timePickerTheme = TimePickerTheme.of(context);
    final bool isDark = themeData.colorScheme.brightness == Brightness.dark;
    final Color textColor = timePickerTheme.hourMinuteTextColor ??
        MaterialStateColor.resolveWith((Set<MaterialState> states) {
          return states.contains(MaterialState.selected)
              ? themeData.colorScheme.primary
              : themeData.colorScheme.onSurface;
        });
    final Color backgroundColor = timePickerTheme.hourMinuteColor ??
        MaterialStateColor.resolveWith((Set<MaterialState> states) {
          return states.contains(MaterialState.selected)
              ? themeData.colorScheme.primary.withOpacity(isDark ? 0.24 : 0.12)
              : themeData.colorScheme.onSurface.withOpacity(0.12);
        });
    final TextStyle style = timePickerTheme.hourMinuteTextStyle ?? themeData.textTheme.displayMedium!;
    final ShapeBorder shape = timePickerTheme.hourMinuteShape ?? MaterialTimePickerWidget.kDefaultShape;

    final Set<MaterialState> states = isSelected ? <MaterialState>{MaterialState.selected} : <MaterialState>{};
    return SizedBox(
      height: MaterialTimePickerWidget.kTimePickerHeaderControlHeight,
      child: Material(
        color: MaterialStateProperty.resolveAs(backgroundColor, states),
        clipBehavior: Clip.antiAlias,
        shape: shape,
        child: InkWell(
          onTap: onTap,
          onDoubleTap: isSelected ? onDoubleTap : null,
          child: Center(
            child: Text(
              text,
              style: style.copyWith(color: MaterialStateProperty.resolveAs(textColor, states)),
              textScaleFactor: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
