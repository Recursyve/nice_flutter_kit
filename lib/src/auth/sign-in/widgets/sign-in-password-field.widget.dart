import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

/// [ReactiveTextField] that will automatically bind to the [FormGroup] of [NiceSignInCubit] provided in [NiceSignIn]
/// Must be used in combination with [NiceSignIn], [NiceSignInEmailField] and [NiceSignInEmailPasswordButton]
///
/// The [SocialProviders] type must be provided and be the same type as the one passed to [NiceSignInCubit]
class NiceSignInPasswordField<SocialProviders> extends StatelessWidget {
  /// Validation messages that will be passed to the [ReactiveTextField]
  final Map<String, ValidationMessageFunction>? validationMessages;

  /// Decoration for the [ReactiveTextField]
  final InputDecoration decoration;

  /// Style of the input text
  final TextStyle? style;

  /// Alignment of the text inside the text field
  final TextAlign textAlign;

  /// Whether we want to obscure text content or not
  final bool obscureText;

  const NiceSignInPasswordField({
    super.key,
    this.validationMessages,
    this.decoration = const InputDecoration(),
    this.style,
    this.textAlign = TextAlign.left,
    this.obscureText = true,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: "password",
      decoration: decoration,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.go,
      obscureText: obscureText,
      style: style,
      textAlign: textAlign,
      onSubmitted: (_) => NiceSignInCubit.of<SocialProviders>(context).signInWithPassword(),
      autofillHints: [
        if (NiceSignInCubit.of<SocialProviders>(context).config.autofillEmailAndPassword) AutofillHints.password,
      ],
    );
  }
}
