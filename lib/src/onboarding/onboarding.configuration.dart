import "dart:ui";

import "package:flutter/foundation.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceOnboardingConfiguration {
  final NiceOnboardingWelcomeConfiguration? welcome;
  final NiceOnboardingIntroductionSequenceConfiguration? introductionSequence;
  final OnboardingPermissionSequenceConfiguration? permissionSequence;
  final VoidCallback? onShown;
  final VoidCallback? onNotShown;
  final VoidCallback? onDone;
  final NiceOnboardingConfigurationSafeArea safeArea;
  final Color? backgroundColor;

  final String? _sharedPrefKey;
  final Set<NicePermissionTypes>? _permissions;

  /// If set to true, the onboarding will always be shown.
  final bool? _debug;

  /// Override the default visibility of the onboarding.
  /// Defaults to [NiceOnboardingBypassEnum.Default]
  final AsyncValueGetter<NiceOnboardingBypassEnum>? bypass;

  // ignore: deprecated_member_use_from_same_package
  String get sharedPrefKey => _sharedPrefKey ?? NiceConfig.onboardingConfig?.sharedPrefKey ?? "ONBOARDING_COMPLETED";

  // ignore: deprecated_member_use_from_same_package
  bool get debug => _debug ?? NiceConfig.onboardingConfig?.debug ?? false;

  // ignore: deprecated_member_use_from_same_package
  Set<NicePermissionTypes>? get permissions => _permissions ?? NiceConfig.onboardingConfig?.permissions;

  int get pageCount =>
      (welcome != null ? 1 : 0) +
      (introductionSequence != null ? 1 : 0) +
      (permissionSequence?.configurations.length ?? 0);

  const NiceOnboardingConfiguration({
    this.safeArea = const NiceOnboardingConfigurationSafeArea(),
    this.welcome,
    this.introductionSequence,
    this.permissionSequence,
    this.onShown,
    this.onNotShown,
    this.onDone,
    String? sharedPrefKey,
    Set<NicePermissionTypes>? permissions,
    bool? debug,
    this.bypass,
    this.backgroundColor,
  })  : _sharedPrefKey = sharedPrefKey,
        _debug = debug,
        _permissions = permissions,
        assert(
          welcome != null || introductionSequence != null || permissionSequence != null,
          "At least one of welcome, introduction or permission is required",
        );
}
