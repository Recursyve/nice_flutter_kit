import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig].
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget is used to show an empty state whenever the list has no items.
/// The empty state will only be showed if both of the following conditions are true:
/// - The list has no values
/// - The list has initialized and the first load has been completed
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
