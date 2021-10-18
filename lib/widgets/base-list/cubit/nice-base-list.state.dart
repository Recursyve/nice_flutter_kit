import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListState<D> extends NiceBaseState {
  final List<D> data;
  final bool loadingMore;
  final bool endReached;

  const NiceBaseListState({
    required bool loading,
    required bool error,
    required this.data,
    required this.loadingMore,
    required this.endReached,
  }) : super(loading, error);

  NiceBaseListState.initialState()
      : data = <D>[],
        loadingMore = false,
        endReached = false,
        super.initialState();

  @override
  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceBaseListState<D> copyWith({
    bool? loading,
    bool? error,
    List<D>? data,
    bool? loadingMore,
    bool? endReached,
  }) {
    return NiceBaseListState<D>(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
      loadingMore: loadingMore ?? this.loadingMore,
      endReached: endReached ?? this.endReached,
    );
  }

  @override
  List<Object> get props => [loading, error, data, loadingMore, endReached];
}
