import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class NiceAccountCreationBaseValidationStrategy {
  const NiceAccountCreationBaseValidationStrategy();

  /// Called when the user presses the next button
  /// This method can have side effects, such as calling the [markAllAsTouched] method on a [FormGroup]
  FutureOr<bool> isValid(BuildContext context);
}
