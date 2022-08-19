import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/base-list/cubit/base-list-cubit-builder.widget.dart';

class BaseListPaginator<D> extends StatefulWidget {
  final List<int> pageSizes;
  final BoxDecoration boxDecoration;
  final EdgeInsets innerPadding;

  BaseListPaginator({
    this.pageSizes: const [10, 25, 50],
    this.boxDecoration: const BoxDecoration(),
    this.innerPadding: EdgeInsets.zero,
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
      child: Padding(
        padding: widget.innerPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildPreviousPageButton(),
            const SizedBox(width: 8),
            _buildCurrentPage(),
            const SizedBox(width: 8),
            _buildNextPageButton(),
            const SizedBox(width: 24),
            _buildPageSize(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousPageButton() {
    return NiceBaseListCubitBuilder<D>(
      buildWhen: (prev, curr) => prev.currentPage != curr.currentPage,
      builder: (context, state) {
        final hasPreviousPage = state.currentPage > 0;

        return IconButton(
          onPressed: hasPreviousPage ? NiceBaseListCubit.of<D>(context).loadPreviousPage : null,
          icon: const Icon(Icons.chevron_left),
        );
      },
    );
  }

  Widget _buildNextPageButton() {
    return NiceBaseListCubitBuilder<D>(
      buildWhen: (prev, curr) => prev.nextPage != curr.nextPage,
      builder: (context, state) {
        final hasNextPage = state.nextPage != null;

        return IconButton(
          onPressed: hasNextPage ? NiceBaseListCubit.of<D>(context).loadNextPage : null,
          icon: const Icon(Icons.chevron_right),
        );
      },
    );
  }

  Widget _buildCurrentPage() {
    return NiceBaseListCubitBuilder<D>(
      buildWhen: (prev, curr) => prev.currentPage != curr.currentPage || prev.pageCount != curr.pageCount,
      builder: (context, state) => Text("${state.currentPage + 1}/${state.pageCount}"),
    );
  }

  Widget _buildPageSize() {
    return NiceBaseListCubitBuilder<D>(
      buildWhen: (prev, curr) => prev.pageSize != curr.pageSize,
      builder: (context, state) {
        final pageSizes = [...widget.pageSizes];

        // If the pageSize from the state in not in the available page sizes,
        // temporary  add it as an option until the user changes it
        if (!pageSizes.contains(state.pageSize)) {
          pageSizes.add(state.pageSize);
        }

        return DropdownButton<int>(
          value: state.pageSize,
          onChanged: (pageSize) {
            if (pageSize != null) NiceBaseListCubit.of<D>(context).setPageSize(pageSize);
          },
          items: [
            for (final pageSize in pageSizes.sorted((a, b) => a - b))
              DropdownMenuItem(
                value: pageSize,
                child: Text("$pageSize"),
              ),
          ],
        );
      },
    );
  }
}
