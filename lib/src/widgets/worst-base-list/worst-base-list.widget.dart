import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:nice_flutter_kit/src/widgets/worst-base-list/widgets/worst-base-list-body.widget.dart";
import "package:nice_flutter_kit/src/widgets/worst-base-list/widgets/worst-base-list-header.widget.dart";
import "package:rxdart/rxdart.dart";

typedef WorstBaseListItemBuilder<D> = Widget Function(BuildContext context, D data, int? index);

class WorstBaseList<D> extends StatefulWidget {
  final WorstBaseListConfig<D> config;
  final WorstBaseListItemBuilder<D> itemBuilder;
  final Widget? title;
  final VoidCallback? onBack;
  final Widget? separator;
  final Widget? emptyState;
  final bool fadeInItems;
  final bool hideSearch;
  final EdgeInsetsGeometry mobilePadding;
  final EdgeInsetsGeometry largePadding;
  final Widget? action;
  final FutureOr<void> Function()? onBeforeSearch;
  final ScrollPhysics scrollPhysics;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final Function(WorstBaseListCubit)? onCubitCreated;
  final bool loadOnInit;

  // These BlocProviders will be placed underneath the NiceBaseListCubit
  final List<BlocProvider> blocProviders;

  const WorstBaseList({
    super.key,
    required this.config,
    required this.itemBuilder,
    this.title,
    this.onBack,
    this.separator,
    this.emptyState,
    this.fadeInItems = false,
    this.hideSearch = false,
    this.action,
    this.blocProviders = const [],
    this.onBeforeSearch,
    this.mobilePadding = const EdgeInsets.fromLTRB(12, 12, 12, 24),
    this.largePadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.scrollController,
    this.shrinkWrap = false,
    this.onCubitCreated,
    this.loadOnInit = true,
  });

  @override
  State<WorstBaseList<D>> createState() => _WorstBaseListState<D>();
}

class _WorstBaseListState<D> extends State<WorstBaseList<D>> {
  final _searchSubject = BehaviorSubject<String>();
  late final WorstBaseListCubit<D> _cubit;
  late final ScrollController _scrollController;

  bool get shouldLoadMore =>
      _scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
      !_scrollController.position.outOfRange;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _cubit = WorstBaseListCubit<D>(config: widget.config);
    if (widget.loadOnInit) {
      _cubit.load();
    }
    // @Marc-Andre Callback utilisé pour exposer le cubit de la niceBaseList dans le but de pouvoir modifier le UI de la base list.
    widget.onCubitCreated?.call(_cubit);

    _searchSubject.distinct().debounceTime(const Duration(milliseconds: 250)).listen((text) async {
      await widget.onBeforeSearch?.call();
      await _cubit.updateSearch(NiceFilterSearchModel(value: text));
    });

    _scrollController.addListener(() {
      if (shouldLoadMore) {
        _cubit.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _searchSubject.close();
    _cubit.close();
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WorstBaseListCubit<D>>.value(
          value: _cubit,
        ),
        ...widget.blocProviders,
      ],
      child: BlocBuilder<WorstBaseListCubit<D>, WorstBaseListState<D>>(
        buildWhen: (prev, curr) => prev.loading != curr.loading || prev.error != curr.error,
        builder: (context, state) {
          if (state.error) {
            return NiceErrorWidget(
              error: NiceLocalizations.of(context).translate("general.an_error_occurred"),
              onRefresh: () => WorstBaseListCubit<D>.of(context).resetAndLoad(),
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
        shrinkWrap: widget.shrinkWrap,
        controller: widget.scrollController == null ? _scrollController : null,
        physics: widget.scrollPhysics,
        // ignore: deprecated_member_use_from_same_package
        padding: NiceLayoutUtils.isPhone(context) ? widget.mobilePadding : widget.largePadding,
        children: [
          WorstBaseListHeader(
            title: widget.title,
            onBack: widget.onBack,
            onSearchChange: (searchQuery) => _searchSubject.add(searchQuery),
            hideSearch: widget.hideSearch,
            action: widget.action,
          ),
          const SizedBox(height: 24),
          BlocBuilder<WorstBaseListCubit<D>, WorstBaseListState<D>>(
            buildWhen: (prev, curr) => prev.values.isEmpty != curr.values.isEmpty || prev.loading != curr.loading,
            builder: (context, state) {
              if (state.values.isEmpty && !state.loading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: widget.emptyState,
                );
              }

              return WorstBaseListBody(
                itemBuilder: widget.itemBuilder,
                separator: widget.separator,
                fadeInItems: widget.fadeInItems,
              );
            },
          ),
          BlocBuilder<WorstBaseListCubit<D>, WorstBaseListState<D>>(
            buildWhen: (prev, curr) => prev.loadingMore != curr.loadingMore,
            builder: (context, state) {
              if (!state.loadingMore) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
