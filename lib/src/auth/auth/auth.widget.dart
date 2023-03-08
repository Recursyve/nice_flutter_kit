import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

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
  final void Function(BuildContext context, NiceAuthState state)? onStateChange;

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
    if (!waitForInitialization) return child;

    return BlocBuilder<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
      buildWhen: (prev, curr) => prev.initialized != curr.initialized,
      builder: (context, state) {
        if (state.initialized) return child;
        return placeholder ?? const SizedBox.shrink();
      },
    );
  }

  Widget _buildBlocListener({required Widget child}) {
    if (onStateChange == null && onUserChange == null && onAccountChange == null) return child;

    return BlocListener<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
      listenWhen: _listenWhen(),
      listener: (context, state) {
        onStateChange?.call(context, state);
        onUserChange?.call(context, state.user);
        onAccountChange?.call(context, state.account);
      },
      child: child,
    );
  }

  BlocListenerCondition<NiceAuthState<User, Account>>? _listenWhen() {
    if (onStateChange != null) return null;
    if (onUserChange != null && onUserChange != null)
      return (prev, curr) => prev.user != curr.user || prev.account != curr.account;
    if (onUserChange != null) return (prev, curr) => prev.user != curr.user;
    if (onAccountChange != null) return (prev, curr) => prev.account != curr.account;
    return (_, __) => false;
  }
}
