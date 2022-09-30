import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/base-list/cubit/base-list-cubit-builder.widget.dart';

typedef NiceBaseListBodyBuilder<D> = Widget Function(D data);
typedef NiceBaseListBodyBuilderIndexed<D> = Widget Function(D data, int index);

class NiceBaseListBody<D> extends StatelessWidget {
  final Axis scrollDirection;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsets padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  final Widget? pageLoadingIndicator;
  final bool pageLoadingIndicatorMaintainSize;

  final NiceBaseListBodyChildDelegate<D> delegate;

  final double loadingThreshold;

  final WidgetBuilder? emptyStateBuilder;

  NiceBaseListBody({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding: EdgeInsets.zero,
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
    this.pageLoadingIndicatorMaintainSize: true,
    this.emptyStateBuilder,
  })  : delegate = NiceBaseListBodyBuilderDelegate(builder),
        super(key: key);

  NiceBaseListBody.indexed({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding: EdgeInsets.zero,
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
    this.pageLoadingIndicatorMaintainSize: true,
    this.emptyStateBuilder,
  })  : delegate = NiceBaseListBodyChildIndexedBuilderDelegate(builder),
        super(key: key);

  NiceBaseListBody.separated({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding: EdgeInsets.zero,
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
    this.pageLoadingIndicatorMaintainSize: true,
    this.emptyStateBuilder,
  })  : delegate = NiceBaseListBodyChildSeparatedBuilderDelegate(
          builder: builder,
          separatorBuilder: separatorBuilder,
        ),
        super(key: key);

  NiceBaseListBody.separatedIndexed({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding: EdgeInsets.zero,
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
    this.pageLoadingIndicatorMaintainSize: true,
    this.emptyStateBuilder,
  })  : delegate = NiceBaseListBodyChildSeparatedIndexedBuilderDelegate(
          builder: builder,
          separatorBuilder: separatorBuilder,
        ),
        super(key: key);

  const NiceBaseListBody.custom({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding: EdgeInsets.zero,
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
    this.pageLoadingIndicatorMaintainSize: true,
    this.emptyStateBuilder,
  }) : super(key: key);

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
              prev.loading != curr.loading,
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
                if (state.values.isNotEmpty)
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
