import 'dart:math' as math;

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

  final bool loadingPage;

  int get currentPage {
    // If we are not at the last page, the nextPage will not be null
    if (nextPage != null) return math.max(nextPage! - 1, 0);

    // If we are a the last page, return the total number of pages
    return pageCount - 1;
  }

  int get pageCount => (total / pageSize).ceil();

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
    required this.loadingPage,
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
        loadingPage: this.loadingPage,
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
        loadingPage: this.loadingPage,
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
        loadingPage: this.loadingPage,
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
