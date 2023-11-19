import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

/// [ReactiveTextField] that will automatically bind to the [FormGroup] of [NiceSignInCubit] provided in [NiceSignIn]
/// Must be used in combination with [NiceSignIn], [NiceSignInPasswordField] and [NiceSignInUsernamePasswordButton]
class NiceSignInUsernameField extends StatefulWidget {
  /// Validation messages that is passed to the [ReactiveTextField]
  final Map<String, ValidationMessageFunction>? validationMessages;

  /// Validators that will be applied to the form control.
  /// Note that the `required` validator is already applied.
  final List<Validator>? validators;

  /// Decoration for the [ReactiveTextField].
  final InputDecoration decoration;

  /// KeyboardType for the [ReactiveTextField].
  final TextInputType? keyboardType;

  /// Style of the input text.
  final TextStyle? style;

  /// Alignment of the text inside the text field.
  final TextAlign textAlign;

  const NiceSignInUsernameField({
    super.key,
    this.validationMessages,
    this.validators,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.style,
    this.textAlign = TextAlign.left,
  });

  @override
  State<NiceSignInUsernameField> createState() => _NiceSignInUsernameFieldState();
}

class _NiceSignInUsernameFieldState extends State<NiceSignInUsernameField> {
  @override
  void initState() {
    super.initState();

    if (widget.validators case final validators?) {
      final formControl = NiceSignInUsernamePasswordFormGroup.of(context).usernameControl;
      formControl.setValidators([
        ...formControl.validators,
        ...validators,
      ]);
    }
  }

  @override
  void didUpdateWidget(covariant NiceSignInUsernameField oldWidget) {
    super.didUpdateWidget(oldWidget);

    final formControl = NiceSignInUsernamePasswordFormGroup.of(context).usernameControl;
    final validators = [
      for (final validator in formControl.validators)
        if (oldWidget.validators?.contains(validator) == false) validator,
      ...?widget.validators,
    ];
    formControl.setValidators(validators);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: "username",
      validationMessages: widget.validationMessages,
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      style: widget.style,
      textAlign: widget.textAlign,
      autofillHints: [
        if (NiceSignInUsernamePasswordConfig.of(context).autofill) AutofillHints.username,
      ],
    );
  }
}
