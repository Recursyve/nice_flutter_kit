import 'package:flutter/foundation.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceOnboardingConfiguration {
  final NiceOnboardingWelcomeConfiguration? welcome;
  final NiceOnboardingIntroductionSequenceConfiguration? introductionSequence;
  final OnboardingPermissionSequenceConfiguration? permissionSequence;
  final VoidCallback? onShown;
  final VoidCallback? onNotShown;
  final VoidCallback? onDone;

  const NiceOnboardingConfiguration({
    this.welcome,
    this.introductionSequence,
    this.permissionSequence,
    this.onShown,
    this.onNotShown,
    this.onDone,
  }) : assert(
          welcome != null || introductionSequence != null || permissionSequence != null,
          "At least one of welcome, introduction or permission is required",
        );

  int get pageCount =>
      (welcome != null ? 1 : 0) +
      (introductionSequence != null ? 1 : 0) +
      (permissionSequence?.configurations.length ?? 0);
}
