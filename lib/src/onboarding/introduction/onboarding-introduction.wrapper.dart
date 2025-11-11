import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:introduction_screen/introduction_screen.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:path/path.dart";

class NiceOnboardingIntroductionSequence extends StatelessWidget {
  final NiceOnboardingIntroductionSequenceConfiguration sequenceConfiguration;
  final VoidCallback onNext;

  const NiceOnboardingIntroductionSequence({
    super.key,
    required this.sequenceConfiguration,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: sequenceConfiguration.globalBackGroundColor ?? Theme.of(context).colorScheme.surface,
      safeAreaList: const [false, false, true, false],
      dotsFlex: sequenceConfiguration.footerConfig.dotsFlex,
      nextFlex: sequenceConfiguration.footerConfig.nextFlex,
      skipOrBackFlex: sequenceConfiguration.footerConfig.skipOrBackFlex,
      nextStyle: sequenceConfiguration.footerConfig.nextButtonStyle,
      skipStyle: sequenceConfiguration.footerConfig.skipButtonStyle,
      doneStyle: sequenceConfiguration.footerConfig.doneButtonStyle,
      baseBtnStyle: sequenceConfiguration.footerConfig.buttonStyle,
      controlsPadding: sequenceConfiguration.footerConfig.controlsPadding,
      dotsDecorator: sequenceConfiguration.footerConfig.dotsDecorator != null
          ? sequenceConfiguration.footerConfig.dotsDecorator!
          : DotsDecorator(
              activeColor: Theme.of(context).colorScheme.secondary,
              color: Theme.of(context).primaryColor,
            ),
      dotsContainerDecorator: sequenceConfiguration.footerConfig.dotsContainerDecorator,
      pages: [
        for (final configuration in sequenceConfiguration.configurations)
          PageViewModel(
            image: _buildImage(imageUrl: configuration.imageUrl, imageWidget: configuration.imageWidget),
            titleWidget: configuration.title != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 24.0, right: 24.0),
                    child: configuration.title,
                  )
                : null,
            decoration: configuration.pageDecoration ??
                PageDecoration(
                  imageAlignment: Alignment.center,
                  imageFlex: 2,
                  bodyFlex: 3,
                  imagePadding: const EdgeInsets.only(),
                  pageColor: configuration.boxDecoration == null ? Theme.of(context).colorScheme.surface : null,
                  contentMargin: const EdgeInsets.all(5),
                  boxDecoration: configuration.boxDecoration,
                ),
            bodyWidget: configuration.bodyWidget ??
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    configuration.paragraph,
                    textAlign: TextAlign.center,
                    style: configuration.paragraphTextStyle ?? const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
          ),
      ],
      showSkipButton: true,
      skip: Text(
        sequenceConfiguration.skip,
        style: sequenceConfiguration.footerConfig.skipButtonTextStyle ??
            TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      next: Text(
        sequenceConfiguration.next,
        style: sequenceConfiguration.footerConfig.nextButtonTextStyle ??
            TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      done: Text(
        sequenceConfiguration.done,
        style: sequenceConfiguration.footerConfig.doneButtonTextStyle ??
            TextStyle(
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

  Widget _buildImage({String? imageUrl, Widget? imageWidget}) {
    if (imageWidget != null) {
      return imageWidget;
    }

    if (imageUrl == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Builder(
        builder: (context) {
          final ext = extension(imageUrl);
          switch (ext) {
            case ".svg":
              return SvgPicture.asset(imageUrl);
            default:
              return Image.asset(imageUrl);
          }
        },
      ),
    );
  }
}
