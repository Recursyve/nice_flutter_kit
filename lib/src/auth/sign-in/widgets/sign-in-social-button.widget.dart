import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Must be used in combination with [NiceSignIn]
class NiceSignInSocialButton extends StatelessWidget {
  /// Type of button to be displayed
  final NiceButtonTypes type;

  /// Callback that will be executed whenever the user taps on the button.
  /// Should return [true] is successfully signed in, and [false] otherwise.
  final Future<bool> Function(BuildContext context) onSignIn;

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
    required this.onSignIn,
    this.style,
    this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return NiceTypedButton.icon(
        type: type,
        onPressed: () => _onSignIn(context),
        style: style,
        icon: icon!,
        label: child,
      );
    }

    return NiceTypedButton(
      type: type,
      onPressed: () => _onSignIn(context),
      style: style,
      child: child,
    );
  }

  Future<void> _onSignIn(BuildContext context) {
    return NiceSignInCubit.of(context).executeSignInCallback(() => onSignIn(context));
  }
}
