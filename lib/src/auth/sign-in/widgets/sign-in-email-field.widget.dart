import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

/// [ReactiveTextField] that will automatically bind to the [FormGroup] of [NiceSignInCubit] provided in [NiceSignIn]
/// Must be used in combination with [NiceSignIn], [NiceSignInPasswordField] and [NiceSignInEmailPasswordButton]
class NiceSignInEmailField<SocialProviders> extends StatelessWidget {
  /// Validation messages that is passed to the [ReactiveTextField]
  final Map<String, ValidationMessageFunction>? validationMessages;

  /// Decoration for the [ReactiveTextField]
  final InputDecoration decoration;

  /// Style of the input text
  final TextStyle? style;

  /// Alignment of the text inside the text field
  final TextAlign textAlign;

  const NiceSignInEmailField({
    super.key,
    this.validationMessages,
    this.decoration = const InputDecoration(),
    this.style,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: "email",
      validationMessages: validationMessages,
      decoration: decoration,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: style,
      textAlign: textAlign,
      autofillHints: [
        if (NiceSignInCubit.of<SocialProviders>(context).config.autofillEmailAndPassword) AutofillHints.email,
      ],
    );
  }
}
