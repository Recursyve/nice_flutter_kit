import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:provider/provider.dart";

/// This widget provides the building blocks for the base list.
///
/// Any widgets related to the base list MUST be used under.
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`).
/// It is important that this value is provided, otherwise it will fallback to `dynamic`, and the base list may
/// have unexpected behaviors.
///
/// This widget will provide multiple things:
/// - The [config] will be provided in the context to it's child.
/// - A [NiceBaseCubit] will be created and provided to it's child, based on the [config].
///
class NiceBaseListConfig<D> extends StatelessWidget {
  static NiceBaseListConfigData<D> of<D>(BuildContext context, {bool listen = false}) =>
      Provider.of(context, listen: listen);

  /// [NiceBaseListConfigData] that will be used for the base list and provided to this widget's child.
  final NiceBaseListConfigData<D> config;

  /// The child [Widget] that will have access to the provided [NiceBaseListConfig] and [NiceBaseListConfig].
  final Widget child;

  const NiceBaseListConfig({
    super.key,
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<NiceBaseListConfigData>.value(
      value: config,
      child: BlocProvider<NiceBaseListCubit<D>>(
        create: (context) => NiceBaseListCubit<D>(
          config: config,
        )..applyDefaultConfigAndMaybeLoad(),
        child: child,
      ),
    );
  }
}
