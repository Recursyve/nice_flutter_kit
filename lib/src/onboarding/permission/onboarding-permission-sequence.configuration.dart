import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceOnboardingPermissionConfiguration {
  final NicePermissionTypes type;
  final String imageUrl;
  final Widget title;
  final Widget paragraph;
  final String activate;
  final Future<void> Function()? onActivated;

  const NiceOnboardingPermissionConfiguration({
    required this.type,
    required this.imageUrl,
    required this.title,
    required this.paragraph,
    required this.activate,
    this.onActivated,
  });
}

class OnboardingPermissionSequenceConfiguration {
  List<NiceOnboardingPermissionConfiguration> configurations;

  OnboardingPermissionSequenceConfiguration({
    required this.configurations,
  });
}
