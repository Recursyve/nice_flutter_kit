import 'package:flutter/src/widgets/framework.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAccountCreationAlwaysEnabledEnabledStrategy extends NiceAccountCreationBaseEnabledStrategy {
  const NiceAccountCreationAlwaysEnabledEnabledStrategy();

  @override
  bool isEnabled(BuildContext context) => true;
}