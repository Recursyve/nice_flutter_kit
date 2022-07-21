import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:path/path.dart';

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
      dotsFlex: sequenceConfiguration.footerConfig.dotsFlex,
      nextFlex: sequenceConfiguration.footerConfig.nextFlex,
      skipOrBackFlex: sequenceConfiguration.footerConfig.skipOrBackFlex,
      baseBtnStyle: sequenceConfiguration.footerConfig.buttonStyle,
      dotsDecorator: sequenceConfiguration.footerConfig.dotsDecorator != null
          ? sequenceConfiguration.footerConfig.dotsDecorator!
          : DotsDecorator(
              activeColor: Theme.of(context).colorScheme.secondary,
              color: Theme.of(context).primaryColor,
            ),
      pages: [
        for (final configuration in sequenceConfiguration.configurations)
          PageViewModel(
            image: _buildImage(configuration.imageUrl),
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
              contentMargin: const EdgeInsets.all(5),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                configuration.paragraph,
                textAlign: TextAlign.center,
                style: const TextStyle(
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

  Widget _buildImage(String imageUrl) {
    final ext = extension(imageUrl);
    switch (ext) {
      case ".svg":
        return SvgPicture.asset(imageUrl);
      default:
        return Image.asset(imageUrl);
    }
  }
}
