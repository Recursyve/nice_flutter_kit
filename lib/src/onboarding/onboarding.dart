import "dart:async";

import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceOnboarding extends StatefulWidget {
  final NiceOnboardingConfiguration configuration;
  final Widget child;
  final ThemeData? onboardingTheme;

  const NiceOnboarding({
    super.key,
    required this.configuration,
    required this.child,
    this.onboardingTheme,
  });

  @override
  _NiceOnboardingState createState() => _NiceOnboardingState();
}

class _NiceOnboardingState extends State<NiceOnboarding> {
  final StreamController<bool> _controller = StreamController<bool>();

  @override
  void initState() {
    super.initState();

    if (NiceConfig.onboardingConfig!.onboardingCompleted) {
      widget.configuration.onNotShown?.call();
    } else {
      widget.configuration.onShown?.call();
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _controller.stream,
      initialData: NiceConfig.onboardingConfig!.onboardingCompleted,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: snapshot.data!
              ? widget.child
              : NiceOnboardingWrapper(
                  theme: widget.onboardingTheme,
                  configuration: widget.configuration,
                  onCompleted: _complete,
                ),
        );
      },
    );
  }

  void _complete() {
    _controller.add(true);
    NiceConfig.onboardingConfig!.onboardingCompleted = true;
    widget.configuration.onDone?.call();
  }
}
