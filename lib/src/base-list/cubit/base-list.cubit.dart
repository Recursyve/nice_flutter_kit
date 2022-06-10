import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListCubit<D> extends NiceBaseCubit<NiceBaseListState<D>> {
  final NiceBaseListConfigData<D> config;

  NiceBaseListCubit({
    required this.config,
  }) : super(NiceBaseListState.initialState(config.defaultFilter));

  factory NiceBaseListCubit.of(BuildContext context) => BlocProvider.of(context);

  Future<void> load() async {
    await wrap(
      callback: () async {
        return;
      },
    );
  }

  Future<void> loadMore() async {
    await wrap(
      callback: () async {
        final result = await config.dataFilterService.filter(
          NiceFilterModel(),
        );
      },
    );
  }
}
