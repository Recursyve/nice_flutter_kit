import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

// Loading overlay that can be stacked on top of a child
class NiceLoadingOverlay extends StatelessWidget {
  final double size;
  final double lineWidth;
  final Widget? child;
  final bool loading;
  final Color? color;
  final StackFit stackFit;

  @Deprecated("Use childAbsorb instead")
  final bool absorb;

  /// control the [AbsorbPointer.absorbing] of the [child]
  final bool? childAbsorb;

  @Deprecated("Use childLoadingOpacity instead")
  final double opacity;

  /// control the [Opacity.opacity] of the [child] when [loading]
  final double? childLoadingOpacity;

  /// control the [Visibility.visible] of the [child] when [loading]
  final bool childLoadingVisibility;

  const NiceLoadingOverlay({
    super.key,
    this.size = 72,
    this.lineWidth = 7,
    this.child,
    this.loading = true,
    this.color,
    this.stackFit = StackFit.loose,
    this.absorb = false,
    this.childAbsorb,
    this.opacity = 1.0,
    this.childLoadingOpacity,
    this.childLoadingVisibility = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: stackFit,
      children: [
        if (child != null)
          AbsorbPointer(
            absorbing: childAbsorb ?? absorb,
            child: Visibility(
              visible: childLoadingVisibility ? true : !loading,
              child: Opacity(
                opacity: loading ? childLoadingOpacity ?? opacity : 1.0,
                child: child!,
              ),
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
