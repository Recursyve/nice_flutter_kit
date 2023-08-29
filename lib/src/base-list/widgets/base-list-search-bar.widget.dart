import "dart:async";

import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:rxdart/rxdart.dart";

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig]
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget is used to filter items based on a text input.
class NiceBaseListSearchBar<D> extends StatefulWidget {
  /// [BoxDecoration] of the search bar.
  final BoxDecoration decoration;

  /// [InputDecoration] that will be passed to the search bar's [TextField].
  final InputDecoration inputDecoration;

  /// [Duration] that will be used to debounce the [TextField]'s values.
  final Duration debounceDuration;

  final FutureOr<void> Function()? onBeforeSearch;

  const NiceBaseListSearchBar({
    super.key,
    this.decoration = const BoxDecoration(),
    this.inputDecoration = const InputDecoration(),
    this.debounceDuration = const Duration(milliseconds: 300),
    this.onBeforeSearch,
  });

  @override
  State<NiceBaseListSearchBar<D>> createState() => _NiceBaseListSearchBarState();
}

class _NiceBaseListSearchBarState<D> extends State<NiceBaseListSearchBar<D>> {
  final _textEditingController = TextEditingController();
  final _searchSubject = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();

    _searchSubject
        .debounceTime(widget.debounceDuration)
        .switchMap(
          (searchQuery) => Future(() async {
            if (widget.onBeforeSearch case final onBeforeSearch?) {
              await onBeforeSearch();
            }

            if (context.mounted) {
              await NiceBaseListCubit.of<D>(context).setSearchQuery(searchQuery);
            }
          }).asStream(),
        )
        .listen((_) {});

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialSearchQuery = NiceBaseListCubit.of<D>(context).state.searchQuery;
      if (initialSearchQuery != null && initialSearchQuery.isNotEmpty) {
        _textEditingController.text = initialSearchQuery;
      }
    });
  }

  @override
  void dispose() {
    _searchSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: widget.decoration,
      child: TextField(
        controller: _textEditingController,
        decoration: widget.inputDecoration,
        onChanged: _searchSubject.add,
      ),
    );
  }
}
