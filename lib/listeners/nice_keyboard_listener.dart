import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Listen for keyboard key press
class NiceKeyboardListener extends StatelessWidget {
  final Widget child;

  // Return true if the key event has been handled (stop propagation)
  final bool? Function(LogicalKeyboardKey key) onKeyPressed;

  const NiceKeyboardListener({
    Key? key,
    required this.child,
    required this.onKeyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (_, keyEvent) {
        // We ignore the KeyDownEvent, since we don't want 2 time the event for the same key(up + down)
        if (keyEvent is! KeyUpEvent) {
          return onKeyPressed(keyEvent.logicalKey) ?? false ? KeyEventResult.handled : KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
      child: child,
    );
  }
}
