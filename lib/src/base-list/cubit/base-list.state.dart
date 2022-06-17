import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListState<D> extends NiceBaseState {
  final bool initialLoadCompleted;

  final int? nextPage;
  final int pageSize;
  final int total;

  final String? searchQuery;
  final NiceFilterQueryModel? query;
  final NiceFilterOrderModel? order;

  final List<D> values;

  int get currentPage {
    // If we are not at the last page, the nextPage will not be null
    if (nextPage != null) return nextPage! - 1;

    // If we are a the last page, return the total number of pages
    return pageCount;
  }

  int get pageCount => (total / pageSize).ceil();

  NiceFilterModel get filter => NiceFilterModel(
        page: NiceFilterPageModel(
          number: nextPage ?? 0,
          size: pageSize,
        ),
        order: order,
        search: _filterSearch,
        query: query,
      );

  NiceFilterSearchModel? get _filterSearch {
    if (searchQuery == null || searchQuery!.isEmpty) return null;
    return NiceFilterSearchModel(value: searchQuery!);
  }

  const NiceBaseListState({
    required super.loading,
    required super.error,
    required this.initialLoadCompleted,
    required this.nextPage,
    required this.pageSize,
    required this.total,
    required this.searchQuery,
    required this.query,
    required this.order,
    required this.values,
  });

  const NiceBaseListState.initialState()
      : initialLoadCompleted = false,
        nextPage = 0,
        pageSize = 20,
        total = 0,
        searchQuery = null,
        query = null,
        order = null,
        values = const [],
        super.initialState();

  @override
  NiceBaseListState<D> copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceBaseListState<D> copyWithNextPage(int? nextPage) => NiceBaseListState<D>(
        loading: this.loading,
        error: this.error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: this.searchQuery,
        query: this.query,
        order: this.order,
        values: this.values,
      );

  NiceBaseListState<D> copyWithSearchQuery(String? searchQuery) => NiceBaseListState<D>(
        loading: this.loading,
        error: this.error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: this.nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: searchQuery,
        query: this.query,
        order: this.order,
        values: this.values,
      );

  NiceBaseListState<D> copyWithQuery(NiceFilterQueryModel? query) => NiceBaseListState<D>(
        loading: this.loading,
        error: this.error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: this.nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: this.searchQuery,
        query: query,
        order: this.order,
        values: this.values,
      );

  NiceBaseListState<D> copyWithOrder(NiceFilterOrderModel? order) => NiceBaseListState<D>(
        loading: this.loading,
        error: this.error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: this.nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: this.searchQuery,
        query: this.query,
        order: order,
        values: this.values,
      );

  NiceBaseListState<D> copyWith({
    bool? loading,
    bool? error,
    bool? initialLoadCompleted,
    int? pageSize,
    int? total,
    List<D>? values,
  }) {
    return NiceBaseListState<D>(
      loading: loading ?? this.loading,
      error: error ?? false,
      initialLoadCompleted: initialLoadCompleted ?? this.initialLoadCompleted,
      nextPage: this.nextPage,
      pageSize: pageSize ?? this.pageSize,
      total: total ?? this.total,
      order: this.order,
      values: values ?? this.values,
      query: this.query,
      searchQuery: this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [loading, error, nextPage, pageSize, total, order, values, query, searchQuery];
}
