import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";

// Loading overlay that can be stacked on top of a child
class NiceLoadingOverlay extends StatelessWidget {
  final double size;
  final double lineWidth;
  final Widget? child;
  final bool loading;
  final Color? color;

  const NiceLoadingOverlay({
    Key? key,
    this.size = 72,
    this.lineWidth = 7,
    this.child,
    this.loading = true,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child!,
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
