import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig]
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget is used as a shortcut for a [BlocBuilder] of <[NiceBaseListCubit], [NiceBaseListState]>.
class NiceBaseListCubitBuilder<D> extends StatelessWidget {
  final BlocBuilderCondition<NiceBaseListState<D>>? buildWhen;
  final BlocWidgetBuilder<NiceBaseListState<D>> builder;

  const NiceBaseListCubitBuilder({
    super.key,
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
