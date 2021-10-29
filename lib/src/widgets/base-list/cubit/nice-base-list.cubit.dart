import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/widgets/base-list/utils/nice-filter-query.utils.dart';

class NiceBaseListCubit<D> extends NiceBaseCubit<NiceBaseListState<D>> {
  final NiceBaseListConfig<D> config;

  NiceBaseListCubit({
    required this.config,
  }) : super(NiceBaseListState.initialState());

  factory NiceBaseListCubit.of(BuildContext context) => BlocProvider.of(context);

  Future<void> load() async {
    emit(state.copyWith(error: false));

    await wrap(
      callback: () async {
        final List<D> data = await config.filterApi
            .filter(
              NiceFilterModel(
                page: NiceFilterPageModel(number: 0, size: config.itemsPerPage),
                order: state.order ?? config.defaultOrder,
                query: state.query,
                search: state.search,
              ),
            )
            .then((d) => d.values ?? const []);

        emit(
          state.copyWith(
            data: data,
            endReached: data.length < config.itemsPerPage,
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

        final List<D> data = await config.filterApi
            .filter(
              NiceFilterModel(
                page: NiceFilterPageModel(
                  number: state.data.length ~/ config.itemsPerPage,
                  size: config.itemsPerPage,
                ),
                order: state.order ?? config.defaultOrder,
                query: state.query,
                search: state.search,
              ),
            )
            .then((d) => d.values ?? const []);

        emit(
          state.copyWith(
            data: [...state.data, ...data],
            loadingMore: false,
            endReached: data.length < config.itemsPerPage,
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
        NiceFilterQueryUtils.upsertQueryRules(
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
    final newRule = ruleUpdater(oldRule);

    emit(
      state.copyWithQuery(
        NiceFilterQueryUtils.upsertQueryRules(
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
        NiceFilterQueryUtils.removeRuleById(state.query, id),
      ),
    );
    if (reloadData) await load();
  }

  Future<void> updateOrder(NiceFilterOrderModel? order) async {
    emit(state.copyWithOrder(order));
    await load();
  }

  Future<void> resetAndLoad() async {
    emit(NiceBaseListState.initialState());
    await load();
  }

  void setData(List<D> data) {
    emit(state.copyWith(data: data));
  }
}
