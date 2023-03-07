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

  bool isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _controller.onChange,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (!snapshot.data! && isKeyboardVisible) {
            isKeyboardVisible = false;
            final focusScope = FocusScope.of(context);
            if (!focusScope.hasPrimaryFocus) {
              focusScope.unfocus();
            }
          } else if (snapshot.data!) {
            isKeyboardVisible = true;
          }
        }

        return GestureDetector(
          onTap: () {
            final focusScope = FocusScope.of(context);
            if (!focusScope.hasPrimaryFocus) {
              focusScope.unfocus();
            }
          },
          child: widget.child,
        );
      },
    );
  }
}
