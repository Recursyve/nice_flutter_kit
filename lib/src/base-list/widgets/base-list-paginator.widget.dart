import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class BaseListPaginator<D> extends StatefulWidget {
  final List<int> pageSizes;
  final BoxDecoration boxDecoration;

  BaseListPaginator({
    this.pageSizes: const [10, 25, 50],
    this.boxDecoration: const BoxDecoration(),
  })  : assert(pageSizes.length == pageSizes.toSet().length),
        assert(pageSizes.every((pageSize) => pageSize > 0));

  @override
  State<BaseListPaginator<D>> createState() => _BaseListPaginatorState();
}

class _BaseListPaginatorState<D> extends State<BaseListPaginator<D>> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    assert(
      NiceBaseListCubit.of<D>(context).config.mode.supportsPaginator,
      "Base list config '${NiceBaseListCubit.of<D>(context).config.mode}' does not support having a paginator.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: widget.boxDecoration,
      child: Row(
        children: [
          _buildCurrentPage(),
          const SizedBox(width: 20),
          _buildPageSize(),
        ],
      ),
    );
  }

  Widget _buildCurrentPage() {
    return BlocBuilder<NiceBaseListCubit<D>, NiceBaseListState<D>>(
      buildWhen: (prev, curr) => prev.currentPage != curr.currentPage || prev.pageCount != curr.pageCount,
      builder: (context, state) => Text("${state.currentPage}/${state.pageCount}"),
    );
  }

  Widget _buildPageSize() {
    return BlocBuilder<NiceBaseListCubit<D>, NiceBaseListState<D>>(
      buildWhen: (prev, curr) => prev.pageSize != curr.pageSize,
      builder: (context, state) => DropdownButton<int>(
        onChanged: (pageSize) {
          if (pageSize != null) NiceBaseListCubit.of<D>(context).setPageSize(pageSize);
        },
        items: [
          for (final pageSize in widget.pageSizes.sorted((a, b) => a - b))
            DropdownMenuItem(
              value: pageSize,
              child: Text("$pageSize"),
            ),
        ],
      ),
    );
  }
}
