import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.cubit.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.state.dart';
import 'package:nice_flutter_kit/widgets/base-list/nice-base-list.widget.dart';
import 'package:nice_flutter_kit/widgets/nice-animated-fade-in.widget.dart';

class NiceBaseListBody<D> extends StatelessWidget {
  final NiceBaseListItemBuilder<D> itemBuilder;
  final Widget? separator;
  final bool fadeInItems;

  const NiceBaseListBody({
    required this.itemBuilder,
    this.separator,
    required this.fadeInItems,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NiceBaseListCubit, NiceBaseListState>(
      buildWhen: (prev, curr) => prev.data != curr.data,
      builder: (context, state) => ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.data.length,
        itemBuilder: (context, index) => _buildItem(context, state.data[index], index),
        separatorBuilder: (_, __) => separator ?? const SizedBox(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, D data, int index) {
    final child = itemBuilder(context, data);

    if (!fadeInItems) return child;

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
