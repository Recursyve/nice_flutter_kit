import 'package:flutter/widgets.dart';

class NiceLazyLoader extends StatefulWidget {
  final VoidCallback onLoad;
  final double loadingThreshold;
  final ScrollController? scrollController;
  final Widget Function(BuildContext context, ScrollController scrollController) builder;
  final bool dangerouslySkipControllerDisposal;

  const NiceLazyLoader({
    required this.onLoad,
    this.loadingThreshold = 350,
    this.scrollController,
    required this.builder,
    this.dangerouslySkipControllerDisposal = false,
  });

  @override
  State<NiceLazyLoader> createState() => _NiceLazyLoaderState();
}

class _NiceLazyLoaderState extends State<NiceLazyLoader> {
  late final ScrollController? _localScrollController;

  ScrollController get _scrollController => widget.scrollController ?? _localScrollController!;

  @override
  void initState() {
    super.initState();

    if (widget.scrollController == null) {
      _localScrollController = ScrollController();
    } else {
      _localScrollController = null;
    }

    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    if (!widget.dangerouslySkipControllerDisposal) {
      _localScrollController?.dispose();
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter <= widget.loadingThreshold) {
      widget.onLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _scrollController);
  }
}
