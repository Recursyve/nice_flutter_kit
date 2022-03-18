import 'package:flutter/widgets.dart';

class NiceAutomaticUnfocus extends StatelessWidget {
  final Widget child;

  const NiceAutomaticUnfocus({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final focusScope = FocusScope.of(context);
        if (!focusScope.hasPrimaryFocus) {
          focusScope.unfocus();
        }
      },
      child: child,
    );
  }
}
