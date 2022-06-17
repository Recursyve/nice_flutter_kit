import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:rxdart/rxdart.dart';

class NiceBaseListSearchBar<D> extends StatefulWidget {
  final BoxDecoration decoration;
  final InputDecoration inputDecoration;
  final Duration debounceDuration;

  const NiceBaseListSearchBar({
    required this.decoration,
    this.inputDecoration: const InputDecoration(),
    this.debounceDuration: const Duration(milliseconds: 200),
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

    _searchSubject.debounceTime(widget.debounceDuration).listen(NiceBaseListCubit.of<D>(context).setSearchQuery);

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
