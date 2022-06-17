import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/widgets/worst-base-list/utils/worst-filter-query.utils.dart';

class WorstBaseListCubit<D> extends NiceBaseCubit<WorstBaseListState<D>> {
  final WorstBaseListConfig<D> config;

  WorstBaseListCubit({
    required this.config,
  }) : super(WorstBaseListState.initialState());

  factory WorstBaseListCubit.of(BuildContext context) => BlocProvider.of(context);

  Future<void> load() async {
    emit(state.copyWith(error: false));

    await wrap(
      callback: () async {
        final result = await config.filterApi.filter(
          NiceFilterModel(
            page: NiceFilterPageModel(number: 0, size: config.itemsPerPage),
            order: state.order ?? config.defaultOrder,
            query: state.query,
            search: state.search,
          ),
        );

        emit(
          state.copyWith(
            result: result,
            endReached: result.values.length < config.itemsPerPage,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.loading || state.loadingMore || state.endReached) return;

    await wrap(
      loading: false,
      callback: () async {
        emit(state.copyWith(loadingMore: true));

        final result = await config.filterApi.filter(
          NiceFilterModel(
            page: NiceFilterPageModel(
              number: (state.values).length ~/ config.itemsPerPage,
              size: config.itemsPerPage,
            ),
            order: state.order ?? config.defaultOrder,
            query: state.query,
            search: state.search,
          ),
        );

        emit(
          state.copyWith(
            result: NiceFilterResultModel(
              page: result.page,
              total: result.total,
              values: [...state.values, ...result.values],
            ),
            loadingMore: false,
            endReached: result.values.length < config.itemsPerPage,
          ),
        );
      },
    );
  }

  Future<void> updateSearch(NiceFilterSearchModel? search) async {
    emit(state.copyWithSearch(search));
    await load();
  }

  Future<void> updateQuery(NiceFilterQueryModel? query) async {
    emit(state.copyWithQuery(query));
    await load();
  }

  Future<void> upsertQueryRules(List<NiceFilterQueryRuleModel> upsertedRules) async {
    emit(
      state.copyWithQuery(
        WorstFilterQueryUtils.upsertQueryRules(
          state.query,
          upsertedRules,
        ),
      ),
    );
    await load();
  }

  Future<void> updateQueryRule(
    String id,
    NiceFilterQueryRuleModel Function(NiceFilterQueryRuleModel? oldRule) ruleUpdater, {
    bool reloadData = true,
  }) async {
    final oldRule = state.query?.rules.firstWhereOrNull((r) => r is NiceFilterQueryRuleModel && r.id == id);
    final newRule = ruleUpdater(oldRule as NiceFilterQueryRuleModel?);

    emit(
      state.copyWithQuery(
        WorstFilterQueryUtils.upsertQueryRules(
          state.query,
          [newRule],
        ),
      ),
    );
    if (reloadData) await load();
  }

  Future<void> removeQueryRule(String id, {bool reloadData = true}) async {
    emit(
      state.copyWithQuery(
        WorstFilterQueryUtils.removeRuleById(state.query, id),
      ),
    );
    if (reloadData) await load();
  }

  Future<void> updateOrder(NiceFilterOrderModel? order) async {
    emit(state.copyWithOrder(order));
    await load();
  }

  Future<void> resetAndLoad() async {
    emit(WorstBaseListState.initialState());
    await load();
  }

  void setData(List<D> data) {
    emit(
      state.copyWith(
        result: state.result!.copyWith(
          values: [...state.values, ...data],
        ),
      ),
    );
  }

  void updateData(D Function(D) mapFunc) {
    emit(
      state.copyWith(
        result: state.result!.copyWith(
          values: state.values.map((value) => mapFunc(value)).toList(),
        ),
      ),
    );
  }
}
