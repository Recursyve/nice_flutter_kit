import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nice_flutter_kit/onboarding/introduction/onboarding-introduction-sequence.configuration.dart';
import 'package:nice_flutter_kit/widgets/nice-text-accent-punctuation.widget.dart';

class NiceOnboardingIntroductionSequence extends StatelessWidget {
  final NiceOnboardingIntroductionSequenceConfiguration sequenceConfiguration;
  final VoidCallback onNext;

  NiceOnboardingIntroductionSequence({
    required this.sequenceConfiguration,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).backgroundColor,
      isTopSafeArea: true,
      dotsDecorator: DotsDecorator(
        activeColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).primaryColor,
      ),
      pages: [
        for (final configuration in sequenceConfiguration.configurations)
          PageViewModel(
            image: Image.asset(configuration.imageUrl,
            ),
            titleWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: configuration.title,
            ),
            decoration: PageDecoration(
              bodyAlignment: Alignment.topCenter,
              imageAlignment: Alignment.bottomCenter,
              imageFlex: 2,
              bodyFlex: 2,
              imagePadding: const EdgeInsets.only(bottom: 0),
              pageColor: Theme.of(context).backgroundColor,
              contentMargin: EdgeInsets.all(5),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                configuration.paragraph,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
            ),
          ),
      ],
      showSkipButton: true,
      showDoneButton: true,
      skip: Text(
        sequenceConfiguration.skip,
        style: TextStyle(
          color: Theme.of(context).buttonTheme.colorScheme?.secondary,
          fontSize: 16,
        ),
      ),
      next: Text(
        sequenceConfiguration.next,
        style: TextStyle(
          color: Theme.of(context).buttonTheme.colorScheme?.primary,
          fontSize: 16,
        ),
      ),
      done: Text(
        sequenceConfiguration.done,
        style: TextStyle(
          color: Theme.of(context).buttonTheme.colorScheme?.primary,
          fontSize: 16,
        ),
      ),
      animationDuration: 250,
      onDone: onNext,
      scrollPhysics: const NeverScrollableScrollPhysics(),
    );
  }
}
