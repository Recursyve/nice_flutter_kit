import "package:flutter/widgets.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// This widget is part of the base list, and MUST be a child of [NiceBaseListConfig]
///
/// The [D] generic type refers to the filtered type (e.g. `Accounts`). It must be provided and it must be the same type
/// as the [NiceBaseListConfig].
///
/// This widget is used to listen on errors from the [NiceBaseListCubit].
class NiceBaseListErrorListener<D> extends StatelessWidget {
  final void Function(BuildContext context) onError;
  final Widget? child;

  const NiceBaseListErrorListener({
    super.key,
    required this.onError,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NiceBaseListCubitListener<D>(
      listenWhen: (prev, curr) => prev.error != curr.error,
      listener: (context, state) {
        if (state.error) {
          onError(context);
        }
      },
      child: child,
    );
  }
}
