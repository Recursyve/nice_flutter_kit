import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig]
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget is used as a shortcut for a [BlocListener] of <[NiceBaseListCubit], [NiceBaseListState]>.
class NiceBaseListCubitListener<D> extends StatelessWidget {
  final BlocListenerCondition<NiceBaseListState<D>>? listenWhen;
  final BlocWidgetListener<NiceBaseListState<D>> listener;
  final Widget? child;

  const NiceBaseListCubitListener({
    super.key,
    this.listenWhen,
    required this.listener,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<NiceBaseListCubit<D>, NiceBaseListState<D>>(
      listenWhen: listenWhen,
      listener: listener,
      child: child,
    );
  }
}
