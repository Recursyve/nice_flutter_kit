import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderInputPadding extends RenderShiftedBox {
  RenderInputPadding(this._minSize, this._orientation, [RenderBox? child]) : super(child);

  Size get minSize => _minSize;
  Size _minSize;

  set minSize(Size value) {
    if (_minSize == value) {
      return;
    }
    _minSize = value;
    markNeedsLayout();
  }

  Orientation get orientation => _orientation;
  Orientation _orientation;

  set orientation(Orientation value) {
    if (_orientation == value) {
      return;
    }
    _orientation = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null) {
      return math.max(child!.getMinIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null) {
      return math.max(child!.getMinIntrinsicHeight(width), minSize.height);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null) {
      return math.max(child!.getMaxIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null) {
      return math.max(child!.getMaxIntrinsicHeight(width), minSize.height);
    }
    return 0.0;
  }

  Size _computeSize({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    if (child != null) {
      final Size childSize = layoutChild(child!, constraints);
      final double width = math.max(childSize.width, minSize.width);
      final double height = math.max(childSize.height, minSize.height);
      return constraints.constrain(Size(width, height));
    }
    return Size.zero;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    if (child != null) {
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }

    if (position.dx < 0.0 ||
        position.dx > math.max(child!.size.width, minSize.width) ||
        position.dy < 0.0 ||
        position.dy > math.max(child!.size.height, minSize.height)) {
      return false;
    }

    Offset newPosition = child!.size.center(Offset.zero);
    switch (orientation) {
      case Orientation.portrait:
        if (position.dy > newPosition.dy) {
          newPosition += const Offset(0.0, 1.0);
        } else {
          newPosition += const Offset(0.0, -1.0);
        }
        break;
      case Orientation.landscape:
        if (position.dx > newPosition.dx) {
          newPosition += const Offset(1.0, 0.0);
        } else {
          newPosition += const Offset(-1.0, 0.0);
        }
        break;
    }

    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(newPosition),
      position: newPosition,
      hitTest: (BoxHitTestResult result, Offset position) {
        assert(position == newPosition);
        return child!.hitTest(result, position: newPosition);
      },
    );
  }
}
