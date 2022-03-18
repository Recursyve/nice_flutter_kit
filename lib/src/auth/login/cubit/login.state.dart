import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceLoginState extends NiceBaseState {
  const NiceLoginState({
    required bool loading,
    required bool error,
  }) : super(loading, error);

  const NiceLoginState.initialState() : super.initialState();

  @override
  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceLoginState copyWith({
    bool? loading,
    bool? error,
  }) {
    return NiceLoginState(
      loading: loading ?? this.loading,
      error: error ?? false,
    );
  }

  @override
  List<Object?> get props => [loading, error];
}
