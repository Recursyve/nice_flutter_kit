import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

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
        activeColor: Theme.of(context).colorScheme.secondary,
        color: Theme.of(context).primaryColor,
      ),
      pages: [
        for (final configuration in sequenceConfiguration.configurations)
          PageViewModel(
            image: Image.asset(
              configuration.imageUrl,
            ),
            titleWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  configuration.title,
                ],
              ),
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
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
      ),
      next: Text(
        sequenceConfiguration.next,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      done: Text(
        sequenceConfiguration.done,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      animationDuration: 250,
      onDone: onNext,
      onSkip: onNext,
      scrollPhysics: const NeverScrollableScrollPhysics(),
    );
  }
}
