import 'package:flutter/src/widgets/framework.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCreationAlwaysEnabledStrategy implements NiceAccountCreationBaseEnabledStrategy {
  const NiceAccountCreationAlwaysEnabledStrategy();

  @override
  bool isEnabled(BuildContext context) => true;
}
