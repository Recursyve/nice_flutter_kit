import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class WorstBaseListBody<D> extends StatelessWidget {
  final WorstBaseListItemBuilder<D> itemBuilder;
  final Widget? separator;
  final bool fadeInItems;

  const WorstBaseListBody({
    super.key,
    required this.itemBuilder,
    this.separator,
    required this.fadeInItems,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorstBaseListCubit<D>, WorstBaseListState<D>>(
      buildWhen: (prev, curr) => prev.result != curr.result,
      builder: (context, state) => ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.values.length,
        itemBuilder: (context, index) => _buildItem(context, state.values[index], index),
        separatorBuilder: (_, __) => separator ?? const SizedBox(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, D data, int index) {
    final child = itemBuilder(context, data, index);

    if (!fadeInItems) {
      return child;
    }

    return NiceAnimatedFadeIn(
      key: ValueKey(data),
      duration: const Duration(milliseconds: 150),
      delay: index == 0
          ? Duration.zero
          : Duration(
              // Start the animation when the previous item is half done animating
              milliseconds: index * 150 ~/ 2,
            ),
      child: child,
    );
  }
}
