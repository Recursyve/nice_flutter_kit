import "package:nice_flutter_kit/nice_flutter_kit.dart";

class WorstBaseListState<D> extends NiceBaseState {
  final NiceFilterResultModel<D>? result;
  final bool loadingMore;
  final bool endReached;

  final NiceFilterOrderModel? order;
  final NiceFilterQueryModel? query;
  final NiceFilterSearchModel? search;

  List<D> get values => result?.values ?? const [];

  const WorstBaseListState({
    required super.loading,
    required super.error,
    required this.result,
    required this.loadingMore,
    required this.endReached,
    required this.order,
    required this.query,
    required this.search,
  });

  const WorstBaseListState.initialState()
      : result = null,
        loadingMore = false,
        endReached = false,
        order = null,
        query = null,
        search = null,
        super.initialState();

  @override
  NiceBaseState copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  WorstBaseListState<D> copyWith({
    bool? loading,
    bool? error,
    NiceFilterResultModel<D>? result,
    bool? loadingMore,
    bool? endReached,
  }) {
    return WorstBaseListState<D>(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      result: result ?? this.result,
      loadingMore: loadingMore ?? this.loadingMore,
      endReached: endReached ?? this.endReached,
      order: this.order,
      query: this.query,
      search: this.search,
    );
  }

  WorstBaseListState<D> copyWithOrder(NiceFilterOrderModel? order) {
    return WorstBaseListState<D>(
      loading: loading,
      error: error,
      result: result,
      loadingMore: loadingMore,
      endReached: endReached,
      order: order,
      query: query,
      search: search,
    );
  }

  WorstBaseListState<D> copyWithQuery(NiceFilterQueryModel? query) {
    return WorstBaseListState<D>(
      loading: loading,
      error: error,
      result: result,
      loadingMore: loadingMore,
      endReached: endReached,
      order: order,
      query: query,
      search: search,
    );
  }

  WorstBaseListState<D> copyWithSearch(NiceFilterSearchModel? search) {
    return WorstBaseListState<D>(
      loading: loading,
      error: error,
      result: result,
      loadingMore: loadingMore,
      endReached: endReached,
      order: order,
      query: query,
      search: search,
    );
  }

  @override
  List<Object?> get props => [loading, error, result, loadingMore, endReached, order, query, search];
}
