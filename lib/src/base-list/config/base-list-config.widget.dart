import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/src/base-list/config/base-list.config.data.dart';
import 'package:provider/provider.dart';

class NiceBaseListConfig extends StatelessWidget {
  static NiceBaseListConfigData of(BuildContext context) => Provider.of(context, listen: false);

  final NiceBaseListConfigData config;
  final Widget child;

  const NiceBaseListConfig({
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<NiceBaseListConfigData>.value(
      value: config,
      child: child,
    );
  }
}
