import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListState<D> extends NiceBaseState {
  final int? nextPage;
  final int pageLength;
  final int total;

  final String? search;
  final List<NiceFilterQueryModel>? query;
  final NiceFilterOrderModel? order;

  final List<D> values;

  const NiceBaseListState({
    required super.loading,
    required super.error,
    required this.nextPage,
    required this.pageLength,
    required this.total,
    required this.search,
    required this.query,
    required this.order,
    required this.values,
  });

  NiceBaseListState.initialState(NiceFilterModel? defaultFilter)
      : nextPage = defaultFilter?.page?.number ?? 0,
        pageLength = defaultFilter?.page?.size ?? 20,
        total = 0,
        search = defaultFilter?.search?.value,
        query = defaultFilter?.query != null ? [defaultFilter!.query!] : null,
        order = defaultFilter?.order,
        values = const [],
        super.initialState();

  @override
  NiceBaseListState copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceBaseListState copyWithNextPage(int? nextPage) => NiceBaseListState(
        loading: this.loading,
        error: this.error,
        nextPage: nextPage,
        pageLength: this.pageLength,
        total: this.total,
        search: this.search,
        query: this.query,
        order: this.order,
        values: this.values,
      );

  NiceBaseListState copyWith({
    bool? loading,
    bool? error,
    int? pageLength,
    int? total,
    NiceFilterOrderModel? order,
    List<D>? values,
    NiceFilterResultModel? result,
  }) {
    return NiceBaseListState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      nextPage: this.nextPage,
      pageLength: pageLength ?? this.pageLength,
      total: total ?? this.total,
      order: order ?? this.order,
      values: values ?? this.values,
      query: this.query,
      search: this.search,
    );
  }

  @override
  List<Object?> get props => [loading, error, nextPage, pageLength, total, order, values, query, search];
}
