import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/api/data-filter.api.dart';
import 'package:nice_flutter_kit/localizations/nice.localizations.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.cubit.dart';
import 'package:nice_flutter_kit/widgets/base-list/cubit/nice-base-list.state.dart';
import 'package:nice_flutter_kit/widgets/base-list/widgets/nice-base-list-body.widget.dart';
import 'package:nice_flutter_kit/widgets/base-list/widgets/nice-base-list-header.widget.dart';
import 'package:nice_flutter_kit/widgets/nice-error.widget.dart';
import 'package:rxdart/rxdart.dart';

typedef NiceBaseListItemBuilder<D> = Widget Function(BuildContext context, D data);

class NiceBaseList<D> extends StatefulWidget {
  final NiceDataFilterApi<D> filterApi;
  final int itemsPerPage;
  final NiceBaseListItemBuilder<D> itemBuilder;
  final String title;
  final VoidCallback? onBack;
  final Widget? separator;
  final Widget? emptyState;

  const NiceBaseList({
    required this.filterApi,
    this.itemsPerPage: 20,
    required this.itemBuilder,
    required this.title,
    this.onBack,
    this.separator,
    this.emptyState,
  });

  @override
  State<NiceBaseList<D>> createState() => _NiceBaseListState<D>();
}

class _NiceBaseListState<D> extends State<NiceBaseList<D>> {
  final TextEditingController _searchController = TextEditingController();
  final _searchSubject = BehaviorSubject<String>();
  late final NiceBaseListCubit _cubit;
  final ScrollController _scrollController = ScrollController();

  bool get shouldLoadMore =>
      _scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
      !_scrollController.position.outOfRange;

  @override
  void initState() {
    super.initState();
    _cubit = NiceBaseListCubit(
      filterApi: widget.filterApi,
      itemsPerPage: widget.itemsPerPage,
    )..load();

    _searchSubject.distinct().debounceTime(const Duration(milliseconds: 250)).listen((text) {
      _cubit.load(text);
    });

    _searchController.addListener(() {
      _searchSubject.add(_searchController.text);
    });

    _scrollController.addListener(() {
      if (shouldLoadMore) {
        _cubit.loadMore(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchSubject.close();
    _cubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NiceBaseListCubit>.value(
      value: _cubit,
      child: BlocBuilder<NiceBaseListCubit, NiceBaseListState>(
        buildWhen: (prev, curr) => prev.loading != curr.loading || prev.error != curr.error,
        builder: (context, state) {
          if (state.error) {
            return NiceErrorWidget(
              error: NiceLocalizations.of(context).translate("general.an_error_occurred"),
              onRefresh: () => NiceBaseListCubit.of(context).load(),
            );
          }

          return NiceLoadingOverlay(
            loading: state.loading,
            child: _buildList(),
          );
        },
      ),
    );
  }

  Widget _buildList() {
    return Builder(
      builder: (context) => ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: NiceLayoutUtils.isPhone(context)
            ? const EdgeInsets.all(12)
            : const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        children: [
          NiceBaseListHeader(
            title: widget.title,
            onBack: widget.onBack,
            searchController: _searchController,
          ),
          const SizedBox(height: 24),
          BlocBuilder<NiceBaseListCubit, NiceBaseListState>(
            buildWhen: (prev, curr) => prev.data.isEmpty != curr.data.isEmpty || prev.loading != curr.loading,
            builder: (context, state) {
              if (state.data.isEmpty && !state.loading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: widget.emptyState,
                );
              }

              return NiceBaseListBody(
                itemBuilder: widget.itemBuilder,
                separator: widget.separator,
              );
            },
          ),
          BlocBuilder<NiceBaseListCubit, NiceBaseListState>(
            buildWhen: (prev, curr) => prev.loadingMore != curr.loadingMore,
            builder: (context, state) {
              if (!state.loadingMore) return const SizedBox();

              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: LinearProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
