import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Button that will call [NiceSignInCubit.signInWithPassword]
/// Must be used in combination with [NiceSignIn], [NiceSignInUsernameField] and [NiceSignInPasswordField]
class NiceSignInUsernamePasswordButton extends StatelessWidget {
  /// Type of button to be displayed
  final NiceButtonTypes type;

  /// Style of the button
  final ButtonStyle? style;

  /// Text to be displayed in the button, e.g. "Sign in"
  final String text;

  /// Style of the [text]
  final TextStyle? textStyle;

  /// Show a loading spinner in the button
  final bool showLoading;

  /// Line width of the loading spinner, if [showLoading] is true
  final double loadingLineWidth;

  /// Line color of the loading spinner, if [showLoading] is true
  final Color? loadingLineColor;

  const NiceSignInUsernamePasswordButton({
    super.key,
    required this.type,
    this.style,
    required this.text,
    this.textStyle,
    this.showLoading = true,
    this.loadingLineWidth = 3,
    this.loadingLineColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NiceSignInCubit, NiceSignInState>(
      buildWhen: (prev, curr) => prev.loading != curr.loading,
      builder: (context, state) => NiceTypedButton(
        type: type,
        onPressed: switch (state.loading) {
          false => NiceSignInUsernamePasswordConfig.of(context).onSignIn,
          _ => null,
        },
        style: style,
        child: NiceLoadingOverlay(
          loading: state.loading && showLoading,
          lineWidth: loadingLineWidth,
          color: loadingLineColor,
          child: Visibility(
            visible: !(state.loading && showLoading),
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Text(text, style: textStyle),
          ),
        ),
      ),
    );
  }
}
