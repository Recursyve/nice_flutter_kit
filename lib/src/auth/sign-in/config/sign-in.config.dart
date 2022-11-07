import 'package:reactive_forms/reactive_forms.dart';

class NiceSignInConfig {
  /// Whether or not to activate native autofill for the email and password, and save it afterwards.
  final bool autofillEmailAndPassword;

  /// List of validators that the email field will be using.
  final List<ValidatorFunction>? signInEmailFieldValidators;

  const NiceSignInConfig({
    this.autofillEmailAndPassword: false,
    this.signInEmailFieldValidators,
  });
}
