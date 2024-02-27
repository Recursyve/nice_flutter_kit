import "package:flutter/foundation.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:nice_flutter_kit/src/onboarding/enum/onboarding-bypass.enum.dart";

class NiceOnboardingConfiguration {
  final NiceOnboardingWelcomeConfiguration? welcome;
  final NiceOnboardingIntroductionSequenceConfiguration? introductionSequence;
  final OnboardingPermissionSequenceConfiguration? permissionSequence;
  final VoidCallback? onShown;
  final VoidCallback? onNotShown;
  final VoidCallback? onDone;
  final NiceOnboardingConfigurationSafeArea safeArea;

  final String sharedPrefKey;
  final Set<NicePermissionTypes>? permissions;

  /// If set to true, the onboarding will always be shown.
  final bool debug;

  /// Override the default visibility of the onboarding.
  /// Defaults to [NiceOnboardingBypassEnum.Default]
  final AsyncValueGetter<NiceOnboardingBypassEnum?>? bypass;

  int get pageCount =>
      (welcome != null ? 1 : 0) +
      (introductionSequence != null ? 1 : 0) +
      (permissionSequence?.configurations.length ?? 0);

  NiceOnboardingConfiguration({
    this.safeArea = const NiceOnboardingConfigurationSafeArea(),
    this.welcome,
    this.introductionSequence,
    this.permissionSequence,
    this.onShown,
    this.onNotShown,
    this.onDone,
    this.sharedPrefKey = "ONBOARDING_COMPLETED",
    this.permissions,
    this.debug = false,
    this.bypass,
  }) : assert(
          welcome != null || introductionSequence != null || permissionSequence != null,
          "At least one of welcome, introduction or permission is required",
        );
}
