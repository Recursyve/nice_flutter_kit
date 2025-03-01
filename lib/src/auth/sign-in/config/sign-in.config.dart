import "package:reactive_forms/reactive_forms.dart";

class NiceSignInConfig {
  /// Whether or not to activate native autofill for the email and password, and save it afterwards.
  final bool autofillEmailAndPassword;

  /// Validators that will be applied to the email field.
  /// Defaults to `[Validators.required, Validators.email]`. Providing a value will override it.
  final List<Validator>? signInEmailFieldValidators;

  const NiceSignInConfig({
    this.autofillEmailAndPassword = false,
    this.signInEmailFieldValidators,
  });
}
