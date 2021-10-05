import 'package:flutter/foundation.dart';
import 'package:nice_flutter_kit/onboarding/introduction/onboarding-introduction-sequence.configuration.dart';
import 'package:nice_flutter_kit/onboarding/permission/onboarding-permission-sequence.configuration.dart';
import 'package:nice_flutter_kit/onboarding/welcome/onboarding-welcome.configuration.dart';

class NiceOnboardingConfiguration {
  final NiceOnboardingWelcomeConfiguration? welcome;
  final OnboardingIntroductionSequenceConfiguration? introductionSequence;
  final OnboardingPermissionSequenceConfiguration? permissionSequence;
  final VoidCallback? onDone;

  const NiceOnboardingConfiguration({this.welcome, this.introductionSequence, this.permissionSequence, this.onDone})
      : assert(
          welcome != null || introductionSequence != null || permissionSequence != null,
          "At least one of welcome, introduction or permission is required",
        );

  int get pageCount =>
      (welcome != null ? 1 : 0) +
      (introductionSequence != null ? 1 : 0) +
      (permissionSequence?.configurations.length ?? 0);
}
