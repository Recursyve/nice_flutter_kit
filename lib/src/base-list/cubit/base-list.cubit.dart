import "dart:math" as math;

import "package:collection/collection.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceBaseListCubit<D> extends NiceBaseCubit<NiceBaseListState<D>> {
  final NiceBaseListConfigData<D> config;

  NiceBaseListCubit({
    required this.config,
  }) : super(NiceBaseListState<D>.initialState());

  static NiceBaseListCubit<D> of<D>(BuildContext context, {listen = false}) =>
      BlocProvider.of<NiceBaseListCubit<D>>(context, listen: listen);

  /// Applies
  /// - [NiceBaseListConfigData.pageSize]
  /// - [NiceBaseListConfigData.initialPage]
  /// - [NiceBaseListConfigData.initialSearch]
  /// - [NiceBaseListConfigData.initialQuery]
  /// - [NiceBaseListConfigData.initialQuery]
  /// and loads if [NiceBaseListConfigData.autoLoad] is true.
  Future<void> applyDefaultConfigAndMaybeLoad() async {
    emit(
      state
          .copyWith(pageSize: config.pageSize)
          .copyWithNextPage(config.initialPage)
          .copyWithSearchQuery(config.initialSearch?.value)
          .copyWithQuery(config.initialQuery)
          .copyWithOrder(config.initialOrder),
    );

    if (config.autoLoad) {
      await load(resetPaging: false);
    }
    emit(state.copyWith(initialLoadCompleted: true));
  }

  /// Loads values for the [NiceBaseListState.nextPage].
  /// If [resetPaging] is true, [NiceBaseListState.nextPage] will be reset to 0 and [NiceBaseListState.values] will be
  /// replaced by the values to be loaded.
  Future<void> load({required bool resetPaging}) async {
    if (resetPaging) {
      emit(state.copyWithNextPage(0));
    }

    await wrap(
      callback: () async {
        await loadNextPage(
          forceReplaceValues: resetPaging,
          skipLoadingCheck: true,
        );
      },
    );
  }

  /// Loads the previous page, relative to [NiceBaseListState.currentPage].
  /// If [forceReplaceValues] is true, the values returned will replaced the entirety of [NiceBaseListState.values].
  /// If [skipLoadingCheck] is true, the previous page will be loaded, whether this cubit is currently loading a page or
  /// not.
  Future<void> loadPreviousPage({
    bool forceReplaceValues = false,
    bool skipLoadingCheck = false,
  }) {
    final currentPage = state.currentPage;

    if (currentPage <= 0) {
      return SynchronousFuture(null);
    }
    if (!skipLoadingCheck && state.loadingPage) {
      return SynchronousFuture(null);
    }

    return _loadPage(
      math.max(currentPage - 1, 0),
      forceReplaceValues: forceReplaceValues,
    );
  }

  /// Loads the next page, relative to [NiceBaseListState.currentPage].
  /// If [forceReplaceValues] is true, the values returned will replaced the entirety of [NiceBaseListState.values].
  /// If [skipLoadingCheck] is true, the next page will be loaded, whether this cubit is currently loading a page or
  /// not.
  Future<void> loadNextPage({
    bool forceReplaceValues = false,
    bool skipLoadingCheck = false,
  }) {
    if (state.nextPage == null) {
      return SynchronousFuture(null);
    }
    if (!skipLoadingCheck && state.loadingPage) {
      return SynchronousFuture(null);
    }

    return _loadPage(
      state.nextPage ?? 0,
      forceReplaceValues: forceReplaceValues,
    );
  }

  /// Inner method of both [loadPreviousPage] and [loadNextPage].
  ///
  /// If [forceReplaceValues], [NiceBaseListState.value] will be replaced by the values that are going to be returned by
  /// the config's [NiceBaseListDataFilterProvider].
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

  /// Sets the [NiceBaseListState.searchQuery].
  Future<void> setSearchQuery(String? searchQuery, {bool reload = true}) async {
    emit(state.copyWithSearchQuery(searchQuery));
    if (reload) {
      await load(resetPaging: true);
    }
  }

  /// Sets the [NiceBaseListState.query].
  Future<void> setQuery(NiceFilterQueryModel? query, {bool reload = true}) async {
    emit(state.copyWithQuery(query));
    if (reload) {
      await load(resetPaging: true);
    }
  }

  /// Sets the [NiceBaseListState.order].
  Future<void> setOrder(NiceFilterOrderModel? order, {bool reload = true}) async {
    emit(state.copyWithOrder(order));
    if (reload) {
      await load(resetPaging: true);
    }
  }

  /// Sets the [NiceBaseListState.pageSize].
  Future<void> setPageSize(int pageSize, {bool reload = true}) async {
    if (pageSize == state.pageSize) {
      return;
    }

    emit(state.copyWith(pageSize: pageSize));
    if (reload) {
      await load(resetPaging: true);
    }
  }

  /// Sets the [NiceBaseListState.values].
  void setValues(List<D> values) => emit(state.copyWith(values: values));

  /// Sets the [NiceBaseListState.values], via a callback containing the current values.
  void setValuesCallback(List<D> Function(List<D> values) callback) =>
      emit(state.copyWith(values: callback(state.values)));

  /// Prepends [value] to the [NiceBaseListState.values].
  void prependValue(D value) => setValues([value, ...state.values]);

  /// Appends [value] to the [NiceBaseListState.values].
  void appendValue(D value) => setValues([...state.values, value]);

  /// Removes the [NiceBaseListState.values] where the [filter] callback return true.
  void removeValuesWhere(bool Function(D value) filter) {
    final filteredValues = state.values.where((value) => !filter(value)).toList(growable: false);
    setValues(filteredValues);
  }

  /// Update all [NiceBaseListState.values] where [test] returns true, or prepend the [upsertedValue] if [test] returns
  /// false for all [NiceBaseListState.values].
  void updateAllOrPrependValueWhere(bool Function(D value) test, D upsertedValue) {
    _updateAllOrAppendPrependValueWhere(test, upsertedValue, prepend: true);
  }

  /// Update all [NiceBaseListState.values] where [test] returns true, or append the [upsertedValue] if [test] returns
  /// false for all [NiceBaseListState.values].
  void updateAllOrAppendValueWhere(bool Function(D value) test, D upsertedValue) {
    _updateAllOrAppendPrependValueWhere(test, upsertedValue, prepend: false);
  }

  /// Inner function of both [updateAllOrPrependValueWhere] and [updateAllOrAppendValueWhere].
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

  /// Maps all [NiceBaseListState.values] and replaces them with the result.
  void mapValues(D Function(D value) mapper) {
    final mappedValues = state.values.map(mapper).toList(growable: false);
    emit(state.copyWith(values: mappedValues));
  }
}
