import 'package:expandable/expandable.dart';
import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class RadioExpandable extends StatefulWidget {
  /// Widget tha will be displayed when the expandable is collapsed
  final Widget header;

  /// Widget that will be displayed when the expandable is expanded
  final Widget body;

  /// Builder called in order to display the expanded state of the [Expandable]
  ///
  /// This could be used, for example, to display a [Column] containing the [header], a separator, and the [body]
  /// If not provided, the expanded state will only display the [body]
  final Widget Function(BuildContext context, Widget header, Widget body)? expandedBuilder;

  /// Theme data that will be provided to the [Expandable]
  final ExpandableThemeData? theme;

  /// Controller that will be provided to the [Expandable]
  final ExpandableController? controller;

  /// Called whenever the expandable expands (true) or collapses (false).
  final ValueChanged<bool>? onChanged;

  const RadioExpandable({
    // Key is required since this is what is used to keep track of which RadioExpandable is expanded
    required Key key,
    required this.header,
    required this.body,
    this.expandedBuilder,
    this.theme,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RadioExpandable> createState() => _RadioExpandableState();
}

class _RadioExpandableState extends State<RadioExpandable> {
  late final ExpandableController? _localController;

  ExpandableController get _controller => widget.controller ?? _localController!;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _localController = ExpandableController();
    } else {
      _localController = null;
      widget.controller?.addListener(_controllerListener);
    }

    if (widget.onChanged != null) {
      _controller.addListener(() {
        widget.onChanged!(_controller.expanded);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final expandedKey = RadioExpandableProvider.of(context).expandedKey;

    if ((expandedKey == widget.key && !_controller.expanded) || (expandedKey != widget.key && _controller.expanded)) {
      setState(() {
        _controller.toggle();
      });
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_controllerListener);
    _localController?.dispose();
    super.dispose();
  }

  void _controllerListener() {
    if (widget.controller?.expanded ?? false) {
      RadioExpandableProvider.of(context).setExpandedKey(widget.key);
    } else {
      final expandedKey = RadioExpandableProvider.of(context).expandedKey;

      if (expandedKey == widget.key) {
        RadioExpandableProvider.of(context).setExpandedKey(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expandable(
      theme: widget.theme,
      controller: _controller,
      collapsed: widget.header,
      expanded: widget.expandedBuilder?.call(context, widget.header, widget.body) ?? widget.body,
    );
  }
}
