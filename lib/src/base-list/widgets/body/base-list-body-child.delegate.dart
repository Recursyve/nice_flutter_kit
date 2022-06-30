import 'package:flutter/cupertino.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

abstract class NiceBaseListBodyChildDelegate<D> {
  const NiceBaseListBodyChildDelegate();

  /// Builds the child that will be displayed in the list body.
  ///
  /// [data] is the value that was returned by the filter.
  ///
  /// [absoluteIndex] is the absolute index of [data].
  /// That means that if we are at page index 2 and element index 4 with a page size of 20, [absoluteIndex] will be 24.
  ///
  /// [relativeIndex] is the relative index of [data] in relation to the current page.
  /// That means that if we are at page index 2 and element index 4, [relativeIndex] will be 4.
  Widget build(BuildContext context, D data, int absoluteIndex, int relativeIndex, NiceBaseListConfigData config);
}

/// A delegate that builds with a simple callback of the context and the data.
class NiceBaseListBodyChildBuilderDelegate<D> implements NiceBaseListBodyChildDelegate<D> {
  final Widget Function(BuildContext context, D data) builder;

  const NiceBaseListBodyChildBuilderDelegate(this.builder);

  @override
  Widget build(BuildContext context, D data, _, __, ___) {
    return builder(context, data);
  }
}

/// A delegate that builds with a callback of the context, the data and the
class NiceBaseListBodyChildIndexedBuilderDelegate<D> implements NiceBaseListBodyChildDelegate<D> {
  final Widget Function(BuildContext context, D data, int absoluteIndex, int relativeIndex) builder;

  const NiceBaseListBodyChildIndexedBuilderDelegate(this.builder);

  @override
  Widget build(BuildContext context, D data, int absoluteIndex, int relativeIndex, _) {
    return builder(context, data, absoluteIndex, relativeIndex);
  }
}

/// A delegate that builds with a separator between elements.
class NiceBaseListBodyChildSeparatedBuilderDelegate<D> implements NiceBaseListBodyChildDelegate<D> {
  final Widget Function(BuildContext context, D data) childBuilder;
  final WidgetBuilder separatorBuilder;

  const NiceBaseListBodyChildSeparatedBuilderDelegate({
    required this.childBuilder,
    required this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context, D data, int absoluteIndex, int relativeIndex, NiceBaseListConfigData config) {
    final child = childBuilder(context, data);

    final index = config.mode.keepPreviousPageValues ? absoluteIndex : relativeIndex;
    if (index == 0) return child;
    return Column(
      children: [
        separatorBuilder(context),
        child,
      ],
    );
  }
}

/// A mix between [NiceBaseListBodyChildSeparatedBuilderDelegate] and [NiceBaseListBodyChildIndexedBuilderDelegate].
class NiceBaseListBodyChildSeparatedIndexedBuilderDelegate<D> implements NiceBaseListBodyChildDelegate<D> {
  final Widget Function(BuildContext context, D data, int absoluteIndex, int relativeIndex) childBuilder;
  final WidgetBuilder separatorBuilder;

  const NiceBaseListBodyChildSeparatedIndexedBuilderDelegate({
    required this.childBuilder,
    required this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context, D data, int absoluteIndex, int relativeIndex, NiceBaseListConfigData config) {
    final child = childBuilder(context, data, absoluteIndex, relativeIndex);

    final index = config.mode.keepPreviousPageValues ? absoluteIndex : relativeIndex;
    if (index == 0) return child;
    return Column(
      children: [
        separatorBuilder(context),
        child,
      ],
    );
  }
}
