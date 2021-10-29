import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListState<D> extends NiceBaseState {
  final List<D> data;
  final bool loadingMore;
  final bool endReached;

  final NiceFilterOrderModel? order;
  final NiceFilterQueryModel? query;
  final NiceFilterSearchModel? search;

  const NiceBaseListState({
    required bool loading,
    required bool error,
    required this.data,
    required this.loadingMore,
    required this.endReached,
    required this.order,
    required this.query,
    required this.search,
  }) : super(loading, error);

  NiceBaseListState.initialState()
      : data = <D>[],
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
      order: this.order,
      query: this.query,
      search: this.search,
    );
  }

  NiceBaseListState<D> copyWithOrder(NiceFilterOrderModel? order) {
    return NiceBaseListState<D>(
      loading: loading,
      error: error,
      data: data,
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
      data: data,
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
      data: data,
      loadingMore: loadingMore,
      endReached: endReached,
      order: order,
      query: query,
      search: search,
    );
  }

  @override
  List<Object?> get props => [loading, error, data, loadingMore, endReached, order, query, search];
}
