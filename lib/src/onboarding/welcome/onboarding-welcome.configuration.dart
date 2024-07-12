import "package:flutter/widgets.dart";

class NiceOnboardingWelcomeConfiguration {
  final String imageUrl;
  final Widget title;
  final String paragraph;
  final String bottomButtonText;
  final EdgeInsets pagePadding;
  final Color? backgroundColor;
  final TextStyle? paragraphTextStyle;

  const NiceOnboardingWelcomeConfiguration({
    required this.imageUrl,
    required this.title,
    required this.paragraph,
    required this.bottomButtonText,
    this.pagePadding = const EdgeInsets.only(bottom: 20),
    this.backgroundColor,
    this.paragraphTextStyle,
  });
}
