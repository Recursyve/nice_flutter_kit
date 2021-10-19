import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-page.model.dart';
import 'package:nice_flutter_kit/data-filter/models/filter.model.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.state.dart';

class NiceBaseListCubit<D> extends BaseCubit<NiceBaseListState<D>> {
  final NiceBaseListConfig<D> config;

  NiceBaseListCubit({
    required this.config,
  }) : super(NiceBaseListState.initialState());

  factory NiceBaseListCubit.of(BuildContext context) => BlocProvider.of(context);

  Future<void> load([String searchQuery = ""]) async {
    emit(state.copyWith(error: false));

    await wrap(
      callback: () async {
        final List<D> data = await config.filterApi
            .filter(
              NiceFilterModel(
                page: NiceFilterPageModel(number: 0, size: config.itemsPerPage),
                search: NiceFilterSearchModel(value: searchQuery),
                order: config.order,
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

  Future<void> loadMore([String searchQuery = ""]) async {
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
                search: NiceFilterSearchModel(value: searchQuery),
                order: config.order,
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
}
