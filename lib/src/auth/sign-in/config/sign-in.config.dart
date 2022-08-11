class NiceSignInConfig {
  /// Whether or not to activate native autofill for the email and password, and save it afterwards.
  final bool autofillEmailAndPassword;

  const NiceSignInConfig({
    this.autofillEmailAndPassword: false,
  });
}
