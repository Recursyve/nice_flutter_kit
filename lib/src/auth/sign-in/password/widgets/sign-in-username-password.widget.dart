import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:provider/provider.dart";
import "package:reactive_forms/reactive_forms.dart";

/// Called when the user on the "Sign in" button.
/// Should return [true] is the credentials were valid, and [false] otherwise.
typedef NiceUsernamePasswordSignInCallback = Future<bool> Function(String username, String password);

class NiceSignInUsernamePasswordConfig {
  final VoidCallback onSignIn;
  final bool autofill;

  const NiceSignInUsernamePasswordConfig({
    required this.onSignIn,
    required this.autofill,
  });

  factory NiceSignInUsernamePasswordConfig.of(BuildContext context) => Provider.of(context, listen: false);
}

class NiceSignInUsernamePassword extends StatefulWidget {
  final NiceUsernamePasswordSignInCallback onSignIn;
  final bool autofill;

  final Widget child;

  const NiceSignInUsernamePassword({
    super.key,
    required this.onSignIn,
    required this.child,
    this.autofill = false,
  });

  @override
  State<NiceSignInUsernamePassword> createState() => _NiceSignInUsernamePasswordState();
}

class _NiceSignInUsernamePasswordState extends State<NiceSignInUsernamePassword> {
  final _formGroup = NiceSignInUsernamePasswordFormGroup();

  @override
  void initState() {
    super.initState();

    _formGroup.valueChanges.listen((_) => NiceSignInCubit.of(context).clearInvalidCredentials());
  }

  @override
  void dispose() {
    _formGroup.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _formGroup,
      child: Provider<NiceSignInUsernamePasswordConfig>.value(
        value: NiceSignInUsernamePasswordConfig(
          onSignIn: _onSignIn,
          autofill: widget.autofill,
        ),
        child: widget.child,
      ),
    );
  }

  Future<void> _onSignIn() async {
    if (NiceSignInCubit.of(context).state.loading) {
      return;
    }

    NiceSignInCubit.of(context).clearInvalidCredentials();

    if (_formGroup.invalid) {
      _formGroup.markAllAsTouched();
      return;
    }
    final username = _formGroup.usernameControl.value!;
    final password = _formGroup.passwordControl.value!;

    final success = await NiceSignInCubit.of(context).executeSignInCallback(
      () => widget.onSignIn(username, password),
    );

    if (success && context.mounted && widget.autofill) {
      TextInput.finishAutofillContext();
    }
  }
}
