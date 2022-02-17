import 'package:flutter/widgets.dart';

class NiceAutomaticKeepAliveClient extends StatefulWidget {
  final Widget child;

  const NiceAutomaticKeepAliveClient({
    required this.child,
  });

  @override
  _NiceAutomaticKeepAliveClientState createState() => _NiceAutomaticKeepAliveClientState();
}

class _NiceAutomaticKeepAliveClientState extends State<NiceAutomaticKeepAliveClient>
    with AutomaticKeepAliveClientMixin<NiceAutomaticKeepAliveClient> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
