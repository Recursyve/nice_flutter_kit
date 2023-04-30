import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceAuthState<User extends Object, Account extends Object> extends NiceBaseState {
  final bool initialized;

  final User? user;
  final Account? account;

  /// Whether a user is signed in
  bool get isSignedIn => user != null;

  /// Whether the user is registered
  /// [user] should never be null if [account] is not null
  ///
  /// A user is registered if he's signed in ([isSignedIn]) and has an account
  bool get isRegistered => account != null;

  const NiceAuthState({
    required super.loading,
    required super.error,
    required this.initialized,
    required this.user,
    required this.account,
  });

  // We have to use a static method for initialState, or we get type errors
  static NiceAuthState<User, Account> initialState<User extends Object, Account extends Object>() {
    return NiceAuthState<User, Account>(
      loading: false,
      error: false,
      initialized: false,
      user: null,
      account: null,
    );
  }

  @override
  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error}) => copyWith(loading: loading, error: error);

  NiceAuthState<User, Account> copyWithUserAndAccount(User? user, Account? account) => NiceAuthState(
        loading: loading,
        error: error,
        initialized: this.initialized,
        user: user,
        account: account,
      );

  NiceAuthState<User, Account> copyWith({
    bool? loading,
    bool? error,
    bool? initialized,
  }) {
    return NiceAuthState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      initialized: initialized ?? this.initialized,
      user: this.user,
      account: this.account,
    );
  }

  @override
  List<Object?> get props => [loading, error, initialized, user, account];
}
