import 'package:flutter/cupertino.dart';

abstract class NiceAccountCreationBaseEnabledStrategy {
  /// Used to check if the page associated with this strategy should be part of the [PageView]
  bool isEnabled(BuildContext context);
}
