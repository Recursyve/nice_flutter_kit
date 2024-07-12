import "package:flutter/material.dart";
import "package:introduction_screen/introduction_screen.dart";

class NiceOnboardingIntroductionConfiguration {
  final String imageUrl;
  final String paragraph;
  final Widget? bodyWidget;
  final BoxDecoration? boxDecoration;
  final Widget? imageWidget;
  final PageDecoration? pageDecoration;
  final TextStyle? paragraphTextStyle;
  final Widget? title;

  const NiceOnboardingIntroductionConfiguration({
    this.title,
    required this.imageUrl,
    required this.paragraph,
    this.bodyWidget,
    this.boxDecoration,
    this.imageWidget,
    this.pageDecoration,
    this.paragraphTextStyle,
  });
}

class NiceOnboardingIntroductionSequenceConfiguration {
  final List<NiceOnboardingIntroductionConfiguration> configurations;
  final String skip;
  final String next;
  final String done;
  final NiceOnboardingIntroductionSequenceFooterConfig footerConfig;
  final Color? globalBackGroundColor;

  const NiceOnboardingIntroductionSequenceConfiguration({
    required this.configurations,
    required this.skip,
    required this.next,
    required this.done,
    this.footerConfig = const NiceOnboardingIntroductionSequenceFooterConfig(),
    this.globalBackGroundColor,
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
  final ButtonStyle? nextButtonStyle;
  final ButtonStyle? skipButtonStyle;
  final TextStyle? skipButtonTextStyle;
  final TextStyle? nextButtonTextStyle;
  final TextStyle? doneButtonTextStyle;

  const NiceOnboardingIntroductionSequenceFooterConfig({
    this.dotsDecorator,
    this.dotsContainerDecorator,
    this.dotsFlex = 1,
    this.nextFlex = 1,
    this.skipOrBackFlex = 1,
    this.controlsPadding = const EdgeInsets.all(16.0),
    this.buttonStyle = const ButtonStyle(),
    this.nextButtonStyle,
    this.skipButtonStyle,
    this.nextButtonTextStyle,
    this.skipButtonTextStyle,
    this.doneButtonTextStyle,
  })  : assert(dotsFlex > 0),
        assert(nextFlex > 0),
        assert(skipOrBackFlex > 0);
}
