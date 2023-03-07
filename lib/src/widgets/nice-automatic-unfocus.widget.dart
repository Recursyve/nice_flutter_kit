import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class NiceAutomaticUnfocus extends StatefulWidget {
  final Widget child;

  NiceAutomaticUnfocus({
    required this.child,
  });

  @override
  State<NiceAutomaticUnfocus> createState() => _NiceAutomaticUnfocusState();
}

class _NiceAutomaticUnfocusState extends State<NiceAutomaticUnfocus> {
  final _controller = KeyboardVisibilityController();
  late StreamSubscription<bool> _subscription;

  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _subscription = _controller.onChange.listen(onKeyboardStateChanged);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final focusScope = FocusScope.of(context);
        if (!focusScope.hasPrimaryFocus) {
          focusScope.unfocus();
        }
      },
      child: widget.child,
    );
  }

  void onKeyboardStateChanged(bool hasOpenedKeyboard) {
    if (!hasOpenedKeyboard && isKeyboardVisible) {
      isKeyboardVisible = false;
      final focusScope = FocusScope.of(context);
      if (!focusScope.hasPrimaryFocus) {
        focusScope.unfocus();
      }
    } else if (hasOpenedKeyboard) {
      isKeyboardVisible = true;
    }
  }
}
