import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListState<D> extends NiceBaseState {
  final int? nextPage;
  final int length;
  final String? search;
  final List<NiceFilterQueryModel>? query;
  final NiceFilterOrderModel? order;

  final NiceFilterResultModel<D>? result;

  const NiceBaseListState({
    required super.loading,
    required super.error,
    required this.nextPage,
  });

  const NiceBaseListState.initialState()
      : nextPage = 0,
        super.initialState();

  @override
  NiceBaseListState copyWithLoadingAndError({bool? loading, bool? error}) {
    return copyWith(loading: loading, error: error);
  }

  NiceBaseListState copyWithNextPage(int? nextPage) => NiceBaseListState(
        loading: this.loading,
        error: this.error,
        nextPage: nextPage,
      );

  NiceBaseListState copyWith({
    bool? loading,
    bool? error,
  }) {
    return NiceBaseListState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      nextPage: this.nextPage,
    );
  }

  @override
  List<Object?> get props => [loading, error];
}
