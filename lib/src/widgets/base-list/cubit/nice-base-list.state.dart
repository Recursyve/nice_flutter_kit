import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListState<D> extends NiceBaseState {
  final NiceFilterResultModel<D>? result;
  final bool loadingMore;
  final bool endReached;

  final NiceFilterOrderModel? order;
  final NiceFilterQueryModel? query;
  final NiceFilterSearchModel? search;

  List<D> get values => result?.values ?? const [];

  const NiceBaseListState({
    required bool loading,
    required bool error,
    required this.result,
    required this.loadingMore,
    required this.endReached,
    required this.order,
    required this.query,
    required this.search,
  }) : super(loading, error);

  NiceBaseListState.initialState()
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

  NiceBaseListState<D> copyWith({
    bool? loading,
    bool? error,
    NiceFilterResultModel<D>? result,
    bool? loadingMore,
    bool? endReached,
  }) {
    return NiceBaseListState<D>(
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

  NiceBaseListState<D> copyWithOrder(NiceFilterOrderModel? order) {
    return NiceBaseListState<D>(
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

  NiceBaseListState<D> copyWithQuery(NiceFilterQueryModel? query) {
    return NiceBaseListState<D>(
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

  NiceBaseListState<D> copyWithSearch(NiceFilterSearchModel? search) {
    return NiceBaseListState<D>(
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
