import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";

// Loading overlay that can be stacked on top of a child
class NiceLoadingOverlay extends StatelessWidget {
  final double size;
  final double lineWidth;
  final Widget? child;
  final bool loading;
  final Color? color;
  final StackFit stackFit;
  final bool absorb;
  final double opacity;

  const NiceLoadingOverlay({
    super.key,
    this.size = 72,
    this.lineWidth = 7,
    this.child,
    this.loading = true,
    this.color,
    this.stackFit = StackFit.loose,
    this.absorb = false,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: stackFit,
      children: [
        if (child != null)
          AbsorbPointer(
            absorbing: absorb,
            child: Opacity(
              opacity: loading ? opacity : 1.0,
              child: child!,
            ),
          ),
        if (loading)
          Positioned.fill(
            child: _buildSpinner(),
          ),
      ],
    );
  }

  Widget _buildSpinner() {
    return Builder(
      builder: (context) => SpinKitRing(
        color: color ?? Theme.of(context).colorScheme.secondary,
        size: size,
        lineWidth: lineWidth,
      ),
    );
  }
}
