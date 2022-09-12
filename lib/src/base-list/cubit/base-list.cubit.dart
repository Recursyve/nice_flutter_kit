import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListCubit<D> extends NiceBaseCubit<NiceBaseListState<D>> {
  final NiceBaseListConfigData<D> config;

  NiceBaseListCubit({
    required this.config,
  }) : super(NiceBaseListState<D>.initialState());

  static NiceBaseListCubit<D> of<D>(BuildContext context) => BlocProvider.of<NiceBaseListCubit<D>>(context);

  Future<void> applyDefaultConfigAndMaybeLoad() async {
    emit(
      state
          .copyWith(pageSize: config.pageSize)
          .copyWithNextPage(config.initialPage)
          .copyWithSearchQuery(config.initialSearch?.value)
          .copyWithQuery(config.initialQuery)
          .copyWithOrder(config.initialOrder),
    );

    if (config.autoLoad) await load(resetPaging: false);
    emit(state.copyWith(initialLoadCompleted: true));
  }

  Future<void> load({required bool resetPaging}) async {
    if (resetPaging) emit(state.copyWithNextPage(0));

    await wrap(
      callback: () async {
        await loadNextPage(
          forceReplaceValues: resetPaging,
          skipLoadingCheck: true,
        );
      },
    );
  }

  Future<void> _loadPage(
    int page, {
    required bool forceReplaceValues,
  }) async {
    final loading = forceReplaceValues || !config.mode.keepPreviousValuesOnPageChange;

    emit(state.copyWith(loadingPage: true));

    await wrap(
      loading: loading,
      callback: () async {
        final result = await config.dataFilterProvider.filter(state.getFilterForPage(page));

        emit(
          state.copyWith(
            total: result.total,
            values: [
              if (config.mode.keepPreviousValuesOnPageChange && !forceReplaceValues) ...state.values,
              ...result.values,
            ],
          ).copyWithNextPage(result.nextPage),
        );
      },
    );

    emit(state.copyWith(loadingPage: false));
  }

  Future<void> loadPreviousPage({
    bool forceReplaceValues = false,
    bool skipLoadingCheck = false,
  }) {
    if (state.currentPage <= 0) return SynchronousFuture(null);
    if (!skipLoadingCheck && state.loadingPage) return SynchronousFuture(null);

    return _loadPage(
      math.max(state.currentPage - 1, 0),
      forceReplaceValues: forceReplaceValues,
    );
  }

  Future<void> loadNextPage({
    bool forceReplaceValues = false,
    bool skipLoadingCheck = false,
  }) {
    if (state.nextPage == null) return SynchronousFuture(null);
    if (!skipLoadingCheck && state.loadingPage) return SynchronousFuture(null);

    return _loadPage(
      state.nextPage ?? 0,
      forceReplaceValues: forceReplaceValues,
    );
  }

  Future<void> setSearchQuery(String? searchQuery, {bool reload = true}) async {
    emit(state.copyWithSearchQuery(searchQuery));
    if (reload) await load(resetPaging: true);
  }

  Future<void> setQuery(NiceFilterQueryModel? query, {bool reload = true}) async {
    emit(state.copyWithQuery(query));
    if (reload) await load(resetPaging: true);
  }

  Future<void> setOrder(NiceFilterOrderModel? order, {bool reload = true}) async {
    emit(state.copyWithOrder(order));
    if (reload) await load(resetPaging: true);
  }

  Future<void> setPageSize(int pageSize, {bool reload = true}) async {
    if (pageSize == state.pageSize) return;

    emit(state.copyWith(pageSize: pageSize));
    if (reload) await load(resetPaging: true);
  }

  void setValues(List<D> values) => emit(state.copyWith(values: values));

  void setValuesCallback(List<D> Function(List<D> values) callback) =>
      emit(state.copyWith(values: callback(state.values)));

  void prependValue(D value) => setValues([value, ...state.values]);

  void appendValue(D value) => setValues([...state.values, value]);

  void removeValuesWhere(bool Function(D value) filter) {
    final filteredValues = state.values.where(filter).toList(growable: false);
    setValues(filteredValues);
  }

  void updateAllOrPrependValueWhere(bool Function(D value) test, D upsertedValue) {
    _updateAllOrAppendPrependValueWhere(test, upsertedValue, prepend: true);
  }

  void updateAllOrAppendValueWhere(bool Function(D value) test, D upsertedValue) {
    _updateAllOrAppendPrependValueWhere(test, upsertedValue, prepend: false);
  }

  void _updateAllOrAppendPrependValueWhere(
    bool Function(D value) test,
    D upsertedValue, {
    required bool prepend,
  }) {
    final updateIndexes = state.values
        .mapIndexed(
          (index, value) => test(value) ? index : null,
        )
        .whereType<int>()
        .toSet();

    setValuesCallback(
      (values) => [
        if (prepend && updateIndexes.isEmpty) upsertedValue,
        for (int i = 0; i < values.length; i++)
          if (updateIndexes.contains(i)) upsertedValue else values[i],
        if (!prepend && updateIndexes.isEmpty) upsertedValue,
      ],
    );
  }

  void mapValues(D Function(D value) mapper) {
    final mappedValues = state.values.map(mapper).toList(growable: false);
    emit(state.copyWith(values: mappedValues));
  }
}
