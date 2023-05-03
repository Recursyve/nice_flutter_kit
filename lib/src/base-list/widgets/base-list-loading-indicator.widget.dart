import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig]
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget will display a circular loading spinner over it's child whenever the [NiceBaseListCubit] loads.
/// This widget should normally be placed over the list body.
class NiceBaseListLoadingIndicator<D> extends StatelessWidget {
  /// [Color] of the loading spinner.
  final Color? color;

  /// Size of the loading spinner.
  final double size;

  /// Line width of the loading spinner.
  final double lineWidth;

  /// Opacity of the child when [NiceBaseListCubit] loads.
  final double loadingOpacity;

  /// child [Widget] over which the circular loading spinner will be displayed whenever the [NiceBaseListCubit] loads.
  final Widget child;

  const NiceBaseListLoadingIndicator({
    super.key,
    this.color,
    this.size = 72,
    this.lineWidth = 7,
    this.loadingOpacity = 1,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NiceBaseListCubitBuilder<D>(
      buildWhen: (prev, curr) => prev.loading != curr.loading,
      builder: (context, state) => NiceLoadingOverlay(
        color: color,
        size: size,
        lineWidth: lineWidth,
        opacity: loadingOpacity,
        loading: state.loading,
        child: child,
      ),
    );
  }
}
