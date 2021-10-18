import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.cubit.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.state.dart';
import 'package:nice_flutter_kit/widgets/base-list/nice-base-list.widget.dart';

class NiceBaseListBody<D> extends StatelessWidget {
  final NiceBaseListItemBuilder<D> itemBuilder;
  final Widget? separator;

  const NiceBaseListBody({
    required this.itemBuilder,
    this.separator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NiceBaseListCubit, NiceBaseListState>(
      buildWhen: (prev, curr) => prev.data != curr.data,
      builder: (context, state) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.data.length,
        itemBuilder: (context, index) => itemBuilder(context, state.data[index]),
        separatorBuilder: (_, __) => separator ?? const SizedBox(),
      ),
    );
  }
}
