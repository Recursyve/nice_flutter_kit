import "package:flutter/widgets.dart";

class NiceOnboardingWelcomeConfiguration {
  final String? imageUrl;
  final Widget Function()? imageBuilder;
  final Widget title;
  final String paragraph;
  final String bottomButtonText;
  final EdgeInsets pagePadding;
  final Color? backgroundColor;
  final TextStyle? paragraphTextStyle;

  const NiceOnboardingWelcomeConfiguration({
    this.imageUrl,
    this.imageBuilder,
    required this.title,
    required this.paragraph,
    required this.bottomButtonText,
    this.pagePadding = const EdgeInsets.only(bottom: 20),
    this.backgroundColor,
    this.paragraphTextStyle,
  }) : assert(imageUrl != null || imageBuilder != null, "Either imageUrl or imageBuilder must be provided");
}
