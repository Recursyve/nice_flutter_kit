import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Listens for [NiceSignInState] errors and displays a text
class NiceSignInErrors extends StatelessWidget {
  // Text that will be displayed when [NiceSignInState.error] is true, e.g.: "An error occurred"
  final String errorText;

  // Text that will be displayed when [NiceSignInState.invalidCredentials] is true, e.g.: "Invalid credentials"
  final String invalidCredentialsText;

  /// Style to be applied to the error
  final TextStyle? style;

  /// Alignment to be applied to the error
  final TextAlign textAlign;

  /// If there is no error, this widget will still keep its size, in order to prevent layout shift
  final bool maintainSize;

  const NiceSignInErrors({
    super.key,
    required this.errorText,
    required this.invalidCredentialsText,
    this.style,
    this.textAlign = TextAlign.center,
    this.maintainSize = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NiceSignInCubit, NiceSignInState>(
      buildWhen: (prev, curr) => prev.error != curr.error || prev.invalidCredentials != curr.invalidCredentials,
      builder: (context, state) => Visibility(
        visible: state.error || state.invalidCredentials,
        maintainSize: maintainSize,
        maintainAnimation: maintainSize,
        maintainState: maintainSize,
        child: Text(
          state.error ? errorText : invalidCredentialsText,
          style: style,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
