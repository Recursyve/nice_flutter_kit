import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

typedef NiceBaseListBodyBuilder<D> = Widget Function(D data);
typedef NiceBaseListBodyBuilderIndexed<D> = Widget Function(D data, int index);

class NiceBaseListBody<D> extends StatelessWidget {
  final Axis scrollDirection;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  final NiceBaseListBodyChildDelegate<D> delegate;

  final double loadingThreshold;

  NiceBaseListBody({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data) builder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 350,
  })  : delegate = NiceBaseListBodyChildBuilderDelegate(builder),
        super(key: key);

  NiceBaseListBody.indexed({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data, int absoluteIndex, int relativeIndex) builder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 350,
  })  : delegate = NiceBaseListBodyChildIndexedBuilderDelegate(builder),
        super(key: key);

  NiceBaseListBody.separated({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data) childBuilder,
    required WidgetBuilder separatorBuilder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 350,
  })  : delegate = NiceBaseListBodyChildSeparatedBuilderDelegate(
          childBuilder: childBuilder,
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
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required Widget Function(BuildContext context, D data, int absoluteIndex, int relativeIndex) childBuilder,
    required WidgetBuilder separatorBuilder,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 350,
  })  : delegate = NiceBaseListBodyChildSeparatedIndexedBuilderDelegate(
          childBuilder: childBuilder,
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
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required this.delegate,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.loadingThreshold = 350,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = NiceBaseListCubit.of<D>(context).config;

    if (!config.mode.lazyLoaded) return _buildListView(controller);

    return NiceLazyLoader(
      onLoad: NiceBaseListCubit.of<D>(context).loadNextPage,
      loadingThreshold: loadingThreshold,
      scrollController: controller,
      builder: (context, controller) => _buildListView(controller),
    );
  }

  Widget _buildListView(ScrollController? controller) {
    return Builder(
      builder: (context) {
        final config = NiceBaseListCubit.of<D>(context).config;

        return BlocBuilder<NiceBaseListCubit<D>, NiceBaseListState<D>>(
          buildWhen: (prev, curr) =>
              prev.pageSize != curr.pageSize || prev.currentPage != curr.currentPage || prev.values != curr.values,
          builder: (context, state) {
            final pageIndexStart = state.currentPage * state.pageSize;

            return ListView.builder(
              scrollDirection: scrollDirection,
              controller: controller,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              padding: padding,
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              addRepaintBoundaries: addRepaintBoundaries,
              addSemanticIndexes: addSemanticIndexes,
              cacheExtent: cacheExtent,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
              itemCount: state.values.length,
              itemBuilder: (context, index) {
                final int relativeIndex;
                if (config.mode.keepPreviousPageValues) {
                  relativeIndex = index - pageIndexStart;
                } else {
                  relativeIndex = index;
                }

                final int absoluteIndex;
                if (config.mode.keepPreviousPageValues) {
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
            );
          },
        );
      },
    );
  }
}
