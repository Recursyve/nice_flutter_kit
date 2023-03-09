import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

typedef NiceBaseListBodyBuilder<D> = Widget Function(D data);
typedef NiceBaseListBodyBuilderIndexed<D> = Widget Function(D data, int index);

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig]
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget is used to display the base list values.
class NiceBaseListBody<D> extends StatelessWidget {
  /// [Axis] on which this widget will scroll.
  final Axis scrollDirection;

  /// [ScrollController] that will be passed to the [CustomScrollView].
  final ScrollController? controller;

  /// Whether the [CustomScrollView] is primary.
  final bool? primary;

  /// [ScrollPhysics] that is going to be passed to [CustomScrollView].
  final ScrollPhysics? physics;

  /// Whether to shrink the [CustomScrollView].
  final bool shrinkWrap;

  /// Padding that will be applied around the entire body.
  final EdgeInsets padding;

  /// Passed to [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Passed to [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Passed to [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Passed to [CustomScrollView.cacheExtent].
  final double? cacheExtent;

  /// Passed to [CustomScrollView.dragStartBehavior].
  final DragStartBehavior dragStartBehavior;

  /// Passed to [CustomScrollView.keyboardDismissBehavior].
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Passed to [CustomScrollView.restorationId].
  final String? restorationId;

  /// Passed to [CustomScrollView.clipBehavior].
  final Clip clipBehavior;

  /// [Widget] this is going to be displayed bellow the items whenever the next page loads.
  final Widget? pageLoadingIndicator;

  /// Whether to maintain the size of the [pageLoadingIndicator], even when it's not loading.
  /// This can be helpful to prevent UI elements shifting on loading.
  final bool pageLoadingIndicatorMaintainSize;

  /// Delegate that will be used to display the items.
  final NiceBaseListBodyChildDelegate<D> delegate;

  /// Distance at which the base list should load next page.
  /// Only used if the [NiceBaseListConfigData.mode] is [NiceBaseListMode.lazyLoaded].
  final double loadingThreshold;

  /// [WidgetBuilder] that will display the resulting [Widget] when there are no items in the list.
  final WidgetBuilder? emptyStateBuilder;

  NiceBaseListBody({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data) builder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 400,
    this.pageLoadingIndicator,
    this.pageLoadingIndicatorMaintainSize = true,
    this.emptyStateBuilder,
  }) : delegate = NiceBaseListBodyBuilderDelegate(builder);

  NiceBaseListBody.indexed({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data, int absoluteIndex, int relativeIndex) builder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 400,
    this.pageLoadingIndicator,
    this.pageLoadingIndicatorMaintainSize = true,
    this.emptyStateBuilder,
  }) : delegate = NiceBaseListBodyChildIndexedBuilderDelegate(builder);

  NiceBaseListBody.separated({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data) builder,
    required WidgetBuilder separatorBuilder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 400,
    this.pageLoadingIndicator,
    this.pageLoadingIndicatorMaintainSize = true,
    this.emptyStateBuilder,
  }) : delegate = NiceBaseListBodyChildSeparatedBuilderDelegate(
          builder: builder,
          separatorBuilder: separatorBuilder,
        );

  NiceBaseListBody.separatedIndexed({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data, int absoluteIndex, int relativeIndex) builder,
    required WidgetBuilder separatorBuilder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 400,
    this.pageLoadingIndicator,
    this.pageLoadingIndicatorMaintainSize = true,
    this.emptyStateBuilder,
  }) : delegate = NiceBaseListBodyChildSeparatedIndexedBuilderDelegate(
          builder: builder,
          separatorBuilder: separatorBuilder,
        );

  const NiceBaseListBody.custom({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required this.delegate,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 400,
    this.pageLoadingIndicator,
    this.pageLoadingIndicatorMaintainSize = true,
    this.emptyStateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final config = NiceBaseListCubit.of<D>(context).config;

    if (!config.mode.lazyLoaded) return _buildList(controller);

    return NiceLazyLoader(
      onLoad: NiceBaseListCubit.of<D>(context).loadNextPage,
      loadingThreshold: loadingThreshold,
      scrollController: controller,
      builder: (context, controller) => _buildList(controller),
    );
  }

  Widget _buildList(ScrollController? controller) {
    return Builder(
      builder: (context) {
        final config = NiceBaseListCubit.of<D>(context).config;

        return NiceBaseListCubitBuilder<D>(
          buildWhen: (prev, curr) =>
              prev.pageSize != curr.pageSize ||
              prev.currentPage != curr.currentPage ||
              prev.values != curr.values ||
              prev.initialLoadCompleted != curr.initialLoadCompleted,
          builder: (context, state) {
            final pageIndexStart = state.currentPage * state.pageSize;

            return CustomScrollView(
              scrollDirection: scrollDirection,
              controller: controller,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              cacheExtent: cacheExtent,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
              slivers: [
                if (state.values.isNotEmpty || !state.initialLoadCompleted)
                  SliverPadding(
                    padding: padding.copyWith(bottom: 0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        addAutomaticKeepAlives: addAutomaticKeepAlives,
                        addRepaintBoundaries: addRepaintBoundaries,
                        addSemanticIndexes: addSemanticIndexes,
                        childCount: state.values.length,
                        (context, index) {
                          final int relativeIndex;
                          if (config.mode.keepPreviousValuesOnPageChange) {
                            relativeIndex = index - pageIndexStart;
                          } else {
                            relativeIndex = index;
                          }

                          final int absoluteIndex;
                          if (config.mode.keepPreviousValuesOnPageChange) {
                            absoluteIndex = index;
                          } else {
                            absoluteIndex = pageIndexStart + index;
                          }

                          return delegate.build(
                            context,
                            state.values[index],
                            absoluteIndex,
                            relativeIndex,
                            config,
                          );
                        },
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: padding.copyWith(bottom: 0),
                    sliver: _buildEmptyStateSliver(),
                  ),
                SliverPadding(
                  padding: padding.copyWith(top: 0),
                  sliver: pageLoadingIndicator != null
                      ? SliverToBoxAdapter(
                          child: _buildPageLoadingIndicator(),
                        )
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPageLoadingIndicator() {
    return NiceBaseListCubitBuilder<D>(
      buildWhen: (prev, curr) =>
          prev.loadingPage != curr.loadingPage ||
          prev.values.isNotEmpty != curr.values.isNotEmpty ||
          curr.loading != curr.loading,
      builder: (context, state) => Visibility(
        visible: state.loadingPage && state.values.isNotEmpty && !state.loading,
        maintainSize: pageLoadingIndicatorMaintainSize,
        maintainAnimation: pageLoadingIndicatorMaintainSize,
        maintainState: pageLoadingIndicatorMaintainSize,
        child: pageLoadingIndicator!,
      ),
    );
  }

  Widget _buildEmptyStateSliver() {
    Widget? child;
    if (emptyStateBuilder != null) {
      child = Center(
        child: Builder(
          builder: emptyStateBuilder!,
        ),
      );
    }

    return SliverFillRemaining(
      hasScrollBody: false,
      child: child,
    );
  }
}
