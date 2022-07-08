import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceBaseListCubitBuilder<D> extends StatelessWidget {
  final BlocBuilderCondition<NiceBaseListState<D>>? buildWhen;
  final BlocWidgetBuilder<NiceBaseListState<D>> builder;

  const NiceBaseListCubitBuilder({
    this.buildWhen,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NiceBaseListCubit<D>, NiceBaseListState<D>>(
      buildWhen: buildWhen,
      builder: builder,
    );
  }
}
