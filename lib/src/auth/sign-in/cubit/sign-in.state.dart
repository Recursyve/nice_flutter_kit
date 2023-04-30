import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceSignInState extends NiceBaseState {
  /// Whether the user entered invalid credentials
  final bool invalidCredentials;

  const NiceSignInState({
    required super.loading,
    required super.error,
    required this.invalidCredentials,
  });

  const NiceSignInState.initialState()
      : invalidCredentials = false,
        super.initialState();

  @override
  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceSignInState copyWith({
    bool? loading,
    bool? error,
    bool? invalidCredentials,
  }) {
    return NiceSignInState(
      loading: loading ?? this.loading,
      error: error ?? false,
      invalidCredentials: invalidCredentials ?? this.invalidCredentials,
    );
  }

  @override
  List<Object?> get props => [loading, error, invalidCredentials];
}
