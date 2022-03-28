import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NicePageViewFormCustomEnabledStrategy implements NicePageViewFormBaseEnabledStrategy {
  final bool Function(BuildContext context) callback;

  const NicePageViewFormCustomEnabledStrategy({
    required this.callback,
  });

  @override
  bool isEnabled(BuildContext context) => callback(context);
}
