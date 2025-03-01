import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Used to provide [NiceAuthCubit], which holds the auth state
///
/// The [User] and [Account] should never be left empty
class NiceAuth<User extends Object, Account extends Object> extends StatelessWidget {
  /// [NiceAuthProvider] that will be used to handle the current user
  /// Passed to [NiceAuthCubit.authProvider]
  final NiceAuthProvider<User, Account> authProvider;

  /// Child [Widget], that will be able to access the [NiceAuthCubit] via [InheritedWidget]
  final Widget child;

  /// Called whenever the [NiceAuthState] changes
  final void Function(BuildContext context, NiceAuthState<User, Account> state)? onStateChange;

  /// Called whenever the [NiceAuthState.user] changes
  final void Function(BuildContext context, User? user)? onUserChange;

  /// Called whenever the [NiceAuthState.account] changes
  final void Function(BuildContext context, Account? account)? onAccountChange;

  /// Display [placeholder] instead of [child] until [NiceAuthState.initialized] is true
  final bool waitForInitialization;

  /// Widget to display if [waitForInitialization] is true, until [NiceAuthState.initialized] is true
  /// Falls back to [SizedBox.shrink]
  final Widget? placeholder;

  const NiceAuth({
    super.key,
    required this.authProvider,
    required this.child,
    this.onStateChange,
    this.onUserChange,
    this.onAccountChange,
    this.waitForInitialization = true,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NiceAuthCubit<User, Account>>(
      create: (context) => NiceAuthCubit<User, Account>(
        authProvider: authProvider,
      )..init(),
      child: _buildBlocListener(
        child: _buildBlocBuilder(
          child: child,
        ),
      ),
    );
  }

  Widget _buildBlocBuilder({required Widget child}) {
    if (!waitForInitialization) {
      return child;
    }

    return BlocBuilder<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
      buildWhen: (prev, curr) => prev.initialized != curr.initialized,
      builder: (context, state) {
        if (state.initialized) {
          return child;
        }
        return placeholder ?? const SizedBox.shrink();
      },
    );
  }

  Widget _buildBlocListener({required Widget child}) {
    if (onStateChange != null) {
      child = BlocListener<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
        listener: onStateChange!,
        child: child,
      );
    }

    if (onUserChange != null) {
      child = BlocListener<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
        listenWhen: (prev, curr) => prev.user != curr.user,
        listener: (context, state) => onUserChange!(context, state.user),
        child: child,
      );
    }

    if (onAccountChange != null) {
      child = BlocListener<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
        listenWhen: (prev, curr) => prev.account != curr.account,
        listener: (context, state) => onAccountChange!(context, state.account),
        child: child,
      );
    }

    return child;
  }
}
