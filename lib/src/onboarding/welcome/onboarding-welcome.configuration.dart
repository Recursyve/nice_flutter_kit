import "package:flutter/widgets.dart";

class NiceOnboardingWelcomeConfiguration {
  final String imageUrl;
  final Widget title;
  final String paragraph;
  final String bottomButtonText;

  const NiceOnboardingWelcomeConfiguration({
    required this.imageUrl,
    required this.title,
    required this.paragraph,
    required this.bottomButtonText,
  });
}
