import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCreationCustomEnabledStrategy implements NiceAccountCreationBaseEnabledStrategy {
  final bool Function(BuildContext context) callback;

  const NiceAccountCreationCustomEnabledStrategy({
    required this.callback,
  });

  @override
  bool isEnabled(BuildContext context) => callback(context);
}
