import "package:flutter/material.dart";
import "package:introduction_screen/introduction_screen.dart";

class NiceOnboardingIntroductionConfiguration {
  final Widget title;
  final String imageUrl;
  final String paragraph;

  const NiceOnboardingIntroductionConfiguration({
    required this.title,
    required this.imageUrl,
    required this.paragraph,
  });
}

class NiceOnboardingIntroductionSequenceConfiguration {
  final List<NiceOnboardingIntroductionConfiguration> configurations;
  final String skip;
  final String next;
  final String done;
  final NiceOnboardingIntroductionSequenceFooterConfig footerConfig;

  const NiceOnboardingIntroductionSequenceConfiguration({
    required this.configurations,
    required this.skip,
    required this.next,
    required this.done,
    this.footerConfig = const NiceOnboardingIntroductionSequenceFooterConfig(),
  }) : assert(configurations.length > 0);
}

class NiceOnboardingIntroductionSequenceFooterConfig {
  final DotsDecorator? dotsDecorator;
  final int dotsFlex;
  final int nextFlex;
  final int skipOrBackFlex;
  final ButtonStyle buttonStyle;

  const NiceOnboardingIntroductionSequenceFooterConfig({
    this.dotsDecorator,
    this.dotsFlex = 1,
    this.nextFlex = 1,
    this.skipOrBackFlex = 1,
    this.buttonStyle = const ButtonStyle(),
  })  : assert(dotsFlex > 0),
        assert(nextFlex > 0),
        assert(skipOrBackFlex > 0);
}
