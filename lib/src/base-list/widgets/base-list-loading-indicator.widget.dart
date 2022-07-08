import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/base-list/cubit/base-list-cubit-builder.widget.dart';

class NiceBaseListLoadingIndicator<D> extends StatelessWidget {
  final Color? color;
  final double size;
  final double lineWidth;

  final Widget child;

  const NiceBaseListLoadingIndicator({
    this.color,
    this.size: 72,
    this.lineWidth: 7,
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
        loading: state.loading,
        child: child,
      ),
    );
  }
}
