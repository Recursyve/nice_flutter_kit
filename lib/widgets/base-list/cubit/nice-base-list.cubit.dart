import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/api/data-filter.api.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-order-direction-type.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-order.model.dart';
import 'package:nice_flutter_kit/data-filter/models/filter-page.model.dart';
import 'package:nice_flutter_kit/data-filter/models/filter.model.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.state.dart';

class NiceBaseListCubit<D> extends BaseCubit<NiceBaseListState<D>> {
  final NiceDataFilterApi<D> filterApi;
  final int itemsPerPage;

  NiceBaseListCubit({
    required this.filterApi,
    required this.itemsPerPage,
  }) : super(NiceBaseListState.initialState());

  factory NiceBaseListCubit.of(BuildContext context) => BlocProvider.of(context);

  Future<void> load([String searchQuery = ""]) async {
    emit(state.copyWith(error: false));

    await wrap(
      () async {
        final List<D> data = await filterApi
            .filter(
              NiceFilterModel(
                page: NiceFilterPageModel(number: 0, size: itemsPerPage),
                search: NiceFilterSearchModel(value: searchQuery),
                order: NiceFilterOrderModel(
                  column: "createdAt",
                  direction: NiceFilterOrderDirectionType.Asc,
                ),
              ),
            )
            .then((d) => d.values ?? const []);

        emit(
          state.copyWith(
            data: data,
            endReached: data.length < itemsPerPage,
          ),
        );
      },
    );
  }

  Future<void> loadMore([String searchQuery = ""]) async {
    if (state.loading || state.loadingMore || state.endReached) return;

    await wrapNoLoading(
      () async {
        emit(state.copyWith(loadingMore: true));

        final List<D> data = await filterApi
            .filter(
              NiceFilterModel(
                page: NiceFilterPageModel(
                  number: state.data.length ~/ itemsPerPage,
                  size: itemsPerPage,
                ),
                search: NiceFilterSearchModel(value: searchQuery),
                order: NiceFilterOrderModel(
                  column: "createdAt",
                  direction: NiceFilterOrderDirectionType.Asc,
                ),
              ),
            )
            .then((d) => d.values ?? const []);

        emit(
          state.copyWith(
            data: [...state.data, ...data],
            loadingMore: false,
            endReached: data.length < itemsPerPage,
          ),
        );
      },
    );
  }
}
