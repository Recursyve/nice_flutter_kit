import 'package:nice_flutter_kit/widgets/nice-text-accent-punctuation.widget.dart';

class NiceOnboardingWelcomeConfiguration {
  final String imageUrl;
  final NiceTextAccentPunctuation title;
  final String paragraph;
  final String bottomButtonText;

  const NiceOnboardingWelcomeConfiguration({
    required this.imageUrl,
    required this.title,
    required this.paragraph,
    required this.bottomButtonText,
  });
}
