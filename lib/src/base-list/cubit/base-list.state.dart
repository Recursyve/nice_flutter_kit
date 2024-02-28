import "dart:math" as math;

import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceBaseListState<D> extends NiceBaseState {
  /// Whether the initial load has been completed.
  final bool initialLoadCompleted;

  /// Index of the next page.
  /// If this value is null, it means that there are no next page.
  final int? nextPage;

  /// Current size of the pages.
  final int pageSize;

  /// Total item count.
  final int total;

  /// Search query that will be used to filter items, via the [NiceBaseListDataFilterProvider].
  final String? searchQuery;

  /// Query that will be used to filter items, via the [NiceBaseListDataFilterProvider].
  final NiceFilterQueryModel? query;

  /// Order that will be used to sort items, via the [NiceBaseListDataFilterProvider].
  final List<NiceFilterOrderModel>? order;

  /// Items that have been filtered by the data filter, and are being displayed.
  final List<D> values;

  /// Whether the base list is currently loading the next page.
  /// This is used to show [NiceBaseListBody.pageLoadingIndicator]
  final bool loadingPage;

  /// Current page index (the last page that was loaded) of the base list.
  ///
  /// If [nextPage] is not null, the current page is [nextPage] - 1, with a minimum of 0.
  /// Otherwise, since we are at the list page, the current page is [pageCount] - 1.
  int get currentPage {
    // If we are not at the last page, the nextPage will not be null
    if (nextPage != null) {
      return math.max(nextPage! - 1, 0);
    }

    // If we are a the last page, return the total number of pages
    return pageCount - 1;
  }

  /// Total page count.
  /// This value may become inaccurate in a lazy loaded base list if the [pageSize] changes after the first page has
  /// loaded.
  int get pageCount => (total / pageSize).ceil();

  NiceFilterSearchModel? get _filterSearch {
    if (searchQuery == null || searchQuery!.isEmpty) {
      return null;
    }

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
    required this.loadingPage,
  });

  const NiceBaseListState.initialState()
      : initialLoadCompleted = false,
        nextPage = 0,
        pageSize = 20,
        total = 0,
        searchQuery = null,
        query = null,
        order = const [],
        values = const [],
        loadingPage = false,
        super.initialState();

  NiceFilterModel getFilterForPage(int page) => NiceFilterModel(
        page: NiceFilterPageModel(
          number: page,
          size: pageSize,
        ),
        order: order,
        search: _filterSearch,
        query: query,
      );

  @override
  NiceBaseListState<D> copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceBaseListState<D> copyWithNextPage(int? nextPage) => NiceBaseListState<D>(
        loading: loading,
        error: error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: this.searchQuery,
        query: this.query,
        order: this.order,
        values: this.values,
        loadingPage: this.loadingPage,
      );

  NiceBaseListState<D> copyWithSearchQuery(String? searchQuery) => NiceBaseListState<D>(
        loading: loading,
        error: error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: this.nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: searchQuery,
        query: this.query,
        order: this.order,
        values: this.values,
        loadingPage: this.loadingPage,
      );

  NiceBaseListState<D> copyWithQuery(NiceFilterQueryModel? query) => NiceBaseListState<D>(
        loading: loading,
        error: error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: this.nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: this.searchQuery,
        query: query,
        order: this.order,
        values: this.values,
        loadingPage: this.loadingPage,
      );

  NiceBaseListState<D> copyWithOrder(List<NiceFilterOrderModel>? order) => NiceBaseListState<D>(
        loading: loading,
        error: error,
        initialLoadCompleted: this.initialLoadCompleted,
        nextPage: this.nextPage,
        pageSize: this.pageSize,
        total: this.total,
        searchQuery: this.searchQuery,
        query: this.query,
        order: order,
        values: this.values,
        loadingPage: this.loadingPage,
      );

  NiceBaseListState<D> copyWith({
    bool? loading,
    bool? error,
    bool? initialLoadCompleted,
    int? pageSize,
    int? total,
    List<D>? values,
    bool? loadingPage,
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
      loadingPage: loadingPage ?? this.loadingPage,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        initialLoadCompleted,
        nextPage,
        pageSize,
        total,
        order,
        values,
        query,
        searchQuery,
        loadingPage,
      ];
}
