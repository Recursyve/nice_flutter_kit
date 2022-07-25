import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

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
