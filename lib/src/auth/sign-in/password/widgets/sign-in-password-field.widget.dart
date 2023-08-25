import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

/// [ReactiveTextField] that will automatically bind to the [FormGroup] of [NiceSignInCubit] provided in [NiceSignIn]
/// Must be used in combination with [NiceSignIn], [NiceSignInUsernameField] and [NiceSignInUsernamePasswordButton]
class NiceSignInPasswordField extends StatefulWidget {
  /// Validation messages that will be passed to the [ReactiveTextField]
  final Map<String, ValidationMessageFunction>? validationMessages;

  /// Validators that will be applied to the form control.
  /// Note that the `required` validator is already applied.
  final List<ValidatorFunction>? validators;

  /// Decoration for the [ReactiveTextField]
  final InputDecoration decoration;

  /// Style of the input text
  final TextStyle? style;

  /// Alignment of the text inside the text field
  final TextAlign textAlign;

  const NiceSignInPasswordField({
    super.key,
    this.validationMessages,
    this.validators,
    this.decoration = const InputDecoration(),
    this.style,
    this.textAlign = TextAlign.left,
  });

  @override
  State<NiceSignInPasswordField> createState() => _NiceSignInPasswordFieldState();
}

class _NiceSignInPasswordFieldState extends State<NiceSignInPasswordField> {
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
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: "password",
      decoration: widget.decoration,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.go,
      obscureText: true,
      style: widget.style,
      textAlign: widget.textAlign,
      onSubmitted: (_) => NiceSignInUsernamePasswordConfig.of(context).onSignIn(),
      autofillHints: [
        if (NiceSignInUsernamePasswordConfig.of(context).autofill) AutofillHints.password,
      ],
    );
  }
}
