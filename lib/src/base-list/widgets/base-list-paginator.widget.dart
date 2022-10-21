import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig]
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget may only be used under a [NiceBaseListConfig] whose [NiceBaseListConfigData]'s mode support a paginator
/// (i.e. [NiceBaseListMode.Paginated])
class NiceBaseListPaginator<D> extends StatefulWidget {
  /// List of page sizes that the user will be able to select.
  /// Items of the list will be reordered in ascending order.
  final List<int> pageSizes;

  /// [BoxDecoration] of the [DecoratedBox] wrapping the paginator.
  final BoxDecoration boxDecoration;

  /// Padding that will be added inside the [DecoratedBox].
  final EdgeInsets innerPadding;

  NiceBaseListPaginator({
    super.key,
    this.pageSizes: const [10, 25, 50],
    this.boxDecoration: const BoxDecoration(),
    this.innerPadding: EdgeInsets.zero,
  })  : assert(pageSizes.length == pageSizes.toSet().length),
        assert(pageSizes.every((pageSize) => pageSize > 0));

  @override
  State<NiceBaseListPaginator<D>> createState() => _NiceBaseListPaginatorState();
}

class _NiceBaseListPaginatorState<D> extends State<NiceBaseListPaginator<D>> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPageSize(),
            const SizedBox(width: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildPreviousPageButton(),
                const SizedBox(width: 8),
                _buildCurrentPage(),
                const SizedBox(width: 8),
                _buildNextPageButton(),
              ],
            ),
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
          splashRadius: 24,
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
          splashRadius: 24,
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
    return Row(
      children: [
        NiceBaseListCubitBuilder<D>(
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
        ),
        const SizedBox(width: 12),
        Text(
          NiceLocalizations.of(context).translate("widgets.nice_base_list.paginator.per_page"),
        ),
      ],
    );
  }
}
