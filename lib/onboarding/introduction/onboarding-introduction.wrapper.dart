import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nice_flutter_kit/onboarding/introduction/onboarding-introduction-sequence.configuration.dart';
import 'package:nice_flutter_kit/widgets/nice-text-accent-punctuation.widget.dart';

class NiceOnboardingIntroductionSequence extends StatelessWidget {
  final OnboardingIntroductionSequenceConfiguration sequenceConfiguration;
  final VoidCallback onNext;

  const NiceOnboardingIntroductionSequence({
    required this.sequenceConfiguration,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroductionScreen(
        globalBackgroundColor: Theme.of(context).backgroundColor,
        isTopSafeArea: true,
        dotsDecorator: DotsDecorator(
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.primary,
        ),
        pages: [
          for (final configuration in sequenceConfiguration.configurations)
            PageViewModel(
              image: Image.asset(configuration.imageUrl),
              titleWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: configuration.title,
              ),
              decoration: PageDecoration(
                bodyAlignment: Alignment.topCenter,
                imageAlignment: Alignment.bottomCenter,
                imageFlex: 3,
                bodyFlex: 2,
                imagePadding: const EdgeInsets.only(bottom: 40),
                pageColor: Theme.of(context).backgroundColor,
              ),
              bodyWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: NiceTextAccentPunctuation(
                  text: configuration.paragraph,
                  punctuation: "",
                  size: 16,
                  align: false,
                  textAlign: TextAlign.center,
                  lineHeight: 1.5,
                ),
              ),
            ),
        ],
        showSkipButton: true,
        showDoneButton: true,
        skip: Text(
          sequenceConfiguration.skip,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
        ),
        next: Text(
          sequenceConfiguration.next,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
        ),
        done: Text(
          sequenceConfiguration.done,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
        ),
        animationDuration: 250,
        onDone: onNext,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
