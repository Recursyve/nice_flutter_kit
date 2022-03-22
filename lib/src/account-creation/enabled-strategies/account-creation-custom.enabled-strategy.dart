import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCustomEnabledStrategy implements NiceAccountCreationBaseEnabledStrategy {
  final bool Function(BuildContext context) callback;

  const NiceAccountCustomEnabledStrategy({
    required this.callback,
  });

  @override
  bool isEnabled(BuildContext context) => callback(context);
}
