import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Listen for keyboard key press
class NiceKeyboardListener extends StatelessWidget {
  final Widget child;

  // Return true if the key event has been handled (stop propagation)
  final KeyEventResult? Function(LogicalKeyboardKey key)? onKeyDown;
  final KeyEventResult? Function(LogicalKeyboardKey key)? onKeyRepeat;
  final KeyEventResult? Function(LogicalKeyboardKey key)? onKeyUp;

  const NiceKeyboardListener({
    Key? key,
    required this.child,
    this.onKeyDown,
    this.onKeyRepeat,
    this.onKeyUp,
  })  : assert(onKeyDown != null || onKeyRepeat != null || onKeyUp != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (_, keyEvent) {
        switch (keyEvent.runtimeType) {
          case KeyUpEvent:
            return onKeyDown?.call(keyEvent.logicalKey) ?? KeyEventResult.ignored;
          case KeyRepeatEvent:
            return onKeyRepeat?.call(keyEvent.logicalKey) ?? KeyEventResult.ignored;
          case KeyUpEvent:
            return onKeyUp?.call(keyEvent.logicalKey) ?? KeyEventResult.ignored;
          default:
            return KeyEventResult.ignored;
        }
      },
      child: child,
    );
  }
}
