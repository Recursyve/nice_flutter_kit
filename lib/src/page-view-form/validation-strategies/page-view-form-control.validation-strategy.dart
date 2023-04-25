import "dart:async";

import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

class NicePageViewFormFormGroupValidationStrategy implements NicePageViewFormBaseValidationStrategy {
  final String? abstractControlName;
  final AbstractControl? abstractControl;
  final bool markAllAsTouchedIfInvalid;

  const NicePageViewFormFormGroupValidationStrategy({
    this.abstractControlName,
    this.abstractControl,
    this.markAllAsTouchedIfInvalid = true,
  }) : assert(
          (abstractControlName == null) != (abstractControl == null),
          "abstractControlName or abstractControl must be passed",
        );

  @override
  FutureOr<bool> isValid(BuildContext context) {
    final control = _getControl(context);
    if (!control.valid) {
      if (markAllAsTouchedIfInvalid) {
        control.markAllAsTouched();
      }
      return false;
    }
    return true;
  }

  AbstractControl _getControl(BuildContext context) {
    if (abstractControlName != null) {
      return (ReactiveForm.of(context, listen: false) as FormGroup).control(abstractControlName!);
    }
    return abstractControl!;
  }
}
