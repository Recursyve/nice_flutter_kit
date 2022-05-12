import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class RadioExpandableProvider extends StatefulWidget {
  /// Key that will be initially expanded
  final Key? initialExpandedKey;

  /// Child which will be able to listen to the expandedKey
  final Widget child;

  const RadioExpandableProvider({
    super.key,
    this.initialExpandedKey,
    required this.child,
  });

  static RadioExpandableProviderData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<RadioExpandableProviderData>();

    if (data == null) {
      throw RadioExpandableProviderNotFoundException();
    }

    return data;
  }

  @override
  State<RadioExpandableProvider> createState() => _RadioExpandableProviderState();
}

class _RadioExpandableProviderState extends State<RadioExpandableProvider> {
  Key? _expandedKey;

  void _setExpandedKey(Key? expandedKey) {
    if (this._expandedKey == expandedKey) return;

    setState(() {
      _expandedKey = expandedKey;
    });
  }

  @override
  void initState() {
    super.initState();

    _expandedKey = widget.initialExpandedKey;
  }

  @override
  Widget build(BuildContext context) {
    return RadioExpandableProviderData(
      expandedKey: _expandedKey,
      child: widget.child,
      state: this,
    );
  }
}

class RadioExpandableProviderData extends InheritedWidget {
  final Key? expandedKey;
  final _RadioExpandableProviderState _state;

  RadioExpandableProviderData({
    required this.expandedKey,
    required Widget child,
    required _RadioExpandableProviderState state,
  })  : _state = state,
        super(child: child);

  void setExpandedKey(Key? expandedKey) => _state._setExpandedKey(expandedKey);

  @override
  bool updateShouldNotify(covariant RadioExpandableProviderData oldWidget) {
    return this.expandedKey != oldWidget.expandedKey;
  }
}
