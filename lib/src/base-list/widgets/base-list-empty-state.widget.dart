import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceBaseListEmptyState<D> extends StatelessWidget {
  final WidgetBuilder emptyStateBuilder;
  final Widget? child;

  const NiceBaseListEmptyState({
    super.key,
    required this.emptyStateBuilder,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NiceBaseListCubitBuilder<D>(
      buildWhen: (prev, curr) =>
          prev.values.isEmpty != curr.values.isEmpty || prev.initialLoadCompleted != curr.initialLoadCompleted,
      builder: (context, state) {
        if (state.values.isNotEmpty || !state.initialLoadCompleted) {
          return child ?? const SizedBox.shrink();
        }

        return emptyStateBuilder(context);
      },
    );
  }
}
