import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class AccountCreationAlwaysValidValidationStrategy implements NiceAccountCreationBaseValidationStrategy {
  const AccountCreationAlwaysValidValidationStrategy();

  @override
  FutureOr<bool> isValid(BuildContext context) => true;
}
