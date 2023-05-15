import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/src/widgets/material-time-picker/material-render-input-padding,widget.dart';

class DayPeriodInputPadding extends SingleChildRenderObjectWidget {
  const DayPeriodInputPadding({
    required Widget super.child,
    required this.minSize,
    required this.orientation,
  });

  final Size minSize;
  final Orientation orientation;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderInputPadding(minSize, orientation);
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderInputPadding renderObject) {
    renderObject
      ..minSize = minSize
      ..orientation = orientation;
  }
}
