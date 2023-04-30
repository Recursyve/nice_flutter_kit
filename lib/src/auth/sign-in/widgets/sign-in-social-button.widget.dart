import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Button that will call [NiceSignInCubit.signInWithSocialProvider]
/// Must be used in combination with [NiceSignIn]
///
/// The [SocialProviders] type must be provided and be the same type as the one passed to [NiceSignInCubit]
class NiceSignInSocialButton<SocialProviders> extends StatelessWidget {
  /// Type of button to be displayed
  final NiceButtonTypes type;

  /// Social provider that this button will sign in with
  final SocialProviders socialProvider;

  /// Style of the button
  final ButtonStyle? style;

  /// Icon to be displayed in front of the text
  /// If provided, [NiceTypedButton.icon] will be used. Otherwise, a normal [NiceTypedButton] will be used
  final Widget? icon;

  /// [Widget] to be displayed in the button, e.g. the name of the provider
  final Widget child;

  const NiceSignInSocialButton({
    super.key,
    required this.type,
    required this.socialProvider,
    this.style,
    this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return NiceTypedButton.icon(
        type: type,
        onPressed: () => NiceSignInCubit.of<SocialProviders>(context).signInWithSocialProvider(socialProvider),
        style: style,
        icon: icon!,
        label: child,
      );
    }

    return NiceTypedButton(
      type: type,
      onPressed: () => NiceSignInCubit.of<SocialProviders>(context).signInWithSocialProvider(socialProvider),
      style: style,
      child: child,
    );
  }
}
