import 'package:nice_flutter_kit/widgets/nice-text-accent-punctuation.widget.dart';

class NiceOnboardingIntroductionConfiguration {
  final NiceTextAccentPunctuation title;
  final String imageUrl;
  final String paragraph;

  const NiceOnboardingIntroductionConfiguration({
    required this.title,
    required this.imageUrl,
    required this.paragraph,
  });
}

class OnboardingIntroductionSequenceConfiguration {
  final List<NiceOnboardingIntroductionConfiguration> configurations;
  final String skip;
  final String next;
  final String done;

  const OnboardingIntroductionSequenceConfiguration({
    required this.configurations,
    required this.skip,
    required this.next,
    required this.done,
  }) : assert(configurations.length > 0);
}
