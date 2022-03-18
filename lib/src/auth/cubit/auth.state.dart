import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAuthState<User extends Object, Account extends Object> extends NiceBaseState {
  final User? user;
  final Account? account;

  const NiceAuthState({
    required bool loading,
    required bool error,
    this.user,
    this.account,
  }) : super(loading, error);

  const NiceAuthState.initialState()
      : user = null,
        account = null,
        super.initialState();

  @override
  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceAuthState copyWith({
    bool? loading,
    bool? error,
  }) {
    return NiceAuthState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [loading, error];
}
