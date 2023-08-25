import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Widget used to provide the [NiceSignInCubit]
/// Required for [NiceSignInUsernameField], [NiceSignInPasswordField], [NiceSignInErrors], [NiceSignInUsernamePasswordButton], [NiceSignInSocialButton]
class NiceSignIn extends StatelessWidget {
  /// Child [Widget] that will be under the [BlocProvider].
  final Widget child;

  const NiceSignIn({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NiceSignInCubit>(
      create: (context) => NiceSignInCubit(),
      child: child,
    );
  }
}
