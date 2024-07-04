import "package:flutter/material.dart";
import "package:introduction_screen/introduction_screen.dart";

class NiceOnboardingIntroductionConfiguration {
  final Widget? title;
  final String imageUrl;
  final Widget? imageWidget;
  final String paragraph;
  final Widget? bodyWidget;
  final PageDecoration? pageDecoration;
  final BoxDecoration? boxDecoration;

  const NiceOnboardingIntroductionConfiguration({
    this.title,
    required this.imageUrl,
    this.imageWidget,
    required this.paragraph,
    this.bodyWidget,
    this.pageDecoration,
    this.boxDecoration,
  });
}

class NiceOnboardingIntroductionSequenceConfiguration {
  final List<NiceOnboardingIntroductionConfiguration> configurations;
  final String skip;
  final String next;
  final String done;
  final NiceOnboardingIntroductionSequenceFooterConfig footerConfig;
  final List<bool>? safeAreaList;

  const NiceOnboardingIntroductionSequenceConfiguration({
    required this.configurations,
    required this.skip,
    required this.next,
    required this.done,
    this.footerConfig = const NiceOnboardingIntroductionSequenceFooterConfig(),
    this.safeAreaList,
  }) : assert(configurations.length > 0);
}

class NiceOnboardingIntroductionSequenceFooterConfig {
  final DotsDecorator? dotsDecorator;
  final BoxDecoration? dotsContainerDecorator;
  final int dotsFlex;
  final int nextFlex;
  final int skipOrBackFlex;
  final ButtonStyle buttonStyle;
  final EdgeInsets controlsPadding;

  const NiceOnboardingIntroductionSequenceFooterConfig({
    this.dotsDecorator,
    this.dotsContainerDecorator,
    this.dotsFlex = 1,
    this.nextFlex = 1,
    this.skipOrBackFlex = 1,
    this.controlsPadding = const EdgeInsets.all(16.0),
    this.buttonStyle = const ButtonStyle(),
  })  : assert(dotsFlex > 0),
        assert(nextFlex > 0),
        assert(skipOrBackFlex > 0);
}
