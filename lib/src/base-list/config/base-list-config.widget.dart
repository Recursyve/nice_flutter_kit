import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:provider/provider.dart';

class NiceBaseListConfig<D> extends StatelessWidget {
  static NiceBaseListConfigData of(BuildContext context, {bool listen = false}) => Provider.of(context, listen: listen);

  final NiceBaseListConfigData<D> config;
  final Widget child;

  const NiceBaseListConfig({
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<NiceBaseListConfigData>.value(
      value: config,
      child: BlocProvider<NiceBaseListCubit<D>>(
        create: (context) => NiceBaseListCubit(
          config: config,
        )..applyDefaultConfigAndMaybeLoad(),
        child: child,
      ),
    );
  }
}
