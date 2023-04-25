import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:reactive_forms/reactive_forms.dart";

/// Widget used to provide the [NiceSignInCubit]
/// Required for [NiceSignInEmailField], [NiceSignInPasswordField], [NiceSignInErrors], [NiceSignInEmailPasswordButton], [NiceSignInSocialButton]
///
/// This widget must be underneath a [NiceAuth] with the exact same [SocialProviders]
class NiceSignIn<SocialProviders, User extends Object, Account extends Object> extends StatelessWidget {
  /// [NiceSignInProvider] to be used when the user signs in with password / social provider.
  final NiceSignInProvider<SocialProviders> signInProvider;

  /// [NiceSignInConfig] to be used for functionalities of the sign in page.
  final NiceSignInConfig config;

  /// Child [Widget] that will be under the [BlocProvider].
  final Widget child;

  const NiceSignIn({
    super.key,
    required this.signInProvider,
    this.config = const NiceSignInConfig(),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NiceSignInCubit<SocialProviders>>(
      create: (context) => NiceSignInCubit<SocialProviders>(
        signInProvider: signInProvider,
        authCubit: NiceAuthCubit.of<User, Account>(context),
        config: config,
      ),
      child: Builder(
        builder: (context) => ReactiveForm(
          formGroup: NiceSignInCubit.of<SocialProviders>(context).signInWithPasswordFormGroup,
          child: child,
        ),
      ),
    );
  }
}
