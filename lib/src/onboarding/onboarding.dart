import "dart:async";
import "dart:collection";

import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:shared_preferences/shared_preferences.dart";

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
  bool _completed = false;
  Future<void>? _initializationFuture;
  late SharedPreferences _sharedPref;
  final HashMap<NicePermissionTypes, bool> isPermissionEnabled = HashMap<NicePermissionTypes, bool>();

  @override
  void initState() {
    super.initState();

    _initializationFuture = _init();
  }

  Future<void> _init() async {
    _sharedPref = await SharedPreferences.getInstance();

    final bypass = await widget.configuration.bypass?.call() ?? NiceOnboardingBypassEnum.Default;
    if (widget.configuration.debug) {
      _completed = true;
    } else {
      switch (bypass) {
        case NiceOnboardingBypassEnum.Show:
          _completed = false;
          break;
        case NiceOnboardingBypassEnum.Hide:
          _completed = true;
          break;
        case NiceOnboardingBypassEnum.Default:
          _completed = _sharedPref.getBool(widget.configuration.sharedPrefKey) ?? false;
      }
    }

    if (_completed) {
      widget.configuration.onNotShown?.call();
    } else {
      widget.configuration.onShown?.call();
    }
    for (final permission in (widget.configuration.permissions ?? {}).toList()) {
      isPermissionEnabled[permission] = await NicePermissionUtils.isPermissionEnabled(permission);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: _completed
              ? widget.child
              : NiceOnboardingWrapper(
                  theme: widget.onboardingTheme,
                  configuration: widget.configuration,
                  onCompleted: _complete,
                  isPermissionEnabled: isPermissionEnabled,
                ),
        );
      },
    );
  }

  void _complete() {
    setState(() {
      _completed = true;
    });
    _sharedPref.setBool(widget.configuration.sharedPrefKey, true);
    widget.configuration.onDone?.call();
  }
}
