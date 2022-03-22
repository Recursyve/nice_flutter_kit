import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceAuthState<User extends Object, Account extends Object> extends NiceBaseState {
  final User? user;
  final Account? account;

  bool get isSignedIn => user != null;

  bool get isRegistered => account != null;

  const NiceAuthState({
    required bool loading,
    required bool error,
    required this.user,
    required this.account,
  }) : super(loading, error);

  // We have to use a static method for initialState, or we get type errors
  static NiceAuthState<User, Account> initialState<User extends Object, Account extends Object>() {
    return NiceAuthState<User, Account>(
      loading: false,
      error: false,
      user: null,
      account: null,
    );
  }

  @override
  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error}) => copyWith(loading: loading, error: error);

  NiceAuthState<User, Account> copyWithUserAndAccount(User? user, Account? account) => NiceAuthState(
        loading: this.loading,
        error: this.error,
        user: user,
        account: account,
      );

  NiceAuthState<User, Account> copyWith({
    bool? loading,
    bool? error,
  }) {
    return NiceAuthState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      user: this.user,
      account: this.account,
    );
  }

  @override
  List<Object?> get props => [loading, error, user, account];
}
