library onboarding;
import 'package:nice_flutter_kit/onboarding/utils/permission-selector.utils.dart';
import 'package:nice_flutter_kit/onboarding/widgets/onboarding-notification.widget.dart';
import 'package:nice_flutter_kit/onboarding/widgets/text-accent-punctuation.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widgets/onboarding-explanation.widget.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

enum PermissionType {
  notification,
  gpsLocalization
}

class ButtonsText {
  final String? next;
  final String? skip;
  final String? done;
  final String? activate;
  final String? rememberLater;

  const ButtonsText(
      {this.next, this.skip, this.done, this.activate, this.rememberLater});
}

class IntroductionConfiguration {
  final String imageUrl;
  final TextAccentPunctuation title;
  final String paragraph;
  final VoidCallback? onNext;

  const IntroductionConfiguration({
    required this.imageUrl,
    required this.title,
    required this.paragraph,
    this.onNext,
  });
}

class NotificationConfiguration extends IntroductionConfiguration {
  final VoidCallback activateNotifications;
  final ButtonsText? activationButtons;
  final PermissionType permissionType;

  const NotificationConfiguration({
    this.activationButtons,
    required onNext,
    required imageUrl,
    required title,
    required paragraph,
    required this.activateNotifications,
    required this.permissionType
  }) : super(
            imageUrl: imageUrl,
            title: title,
            paragraph: paragraph,
            onNext: onNext);
}

class IntroPageConfiguration extends IntroductionConfiguration {
  final String introButtonText;

  const IntroPageConfiguration(
      {required imageUrl,
      required title,
      required paragraph,
      onNext,
      required this.introButtonText})
      : super(
            imageUrl: imageUrl,
            title: title,
            paragraph: paragraph,
            onNext: onNext);
}
class onboardingPage extends StatefulWidget {
  final int currentPage = 0;
  final VoidCallback? onDone;
  final IntroPageConfiguration introPage;
  final List<IntroductionConfiguration>? introductionSequence;
  final List<NotificationConfiguration>? permissionSequence;
  final ButtonsText? buttonsText;
  final Widget child;

  onboardingPage({
    required this.introPage,
    this.introductionSequence,
    this.permissionSequence,
    this.onDone,
    this.buttonsText,
    required this.child
  });

  @override
  _onboardingPageState createState() =>
      _onboardingPageState();

}
class _onboardingPageState extends State<onboardingPage>{
  final PageController _onboardingController = PageController();
  int length = 1;
  @override
  void initState() {
   length += widget.introductionSequence?.length ?? 0;
   length += widget.permissionSequence?.length ?? 0;
   super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder<List<bool>>(
          future: Future.wait([
            // FcmService.isPermissionGranted(),
            // GeolocationService.isPermissionGranted(),
          ]),
          builder: (context, snapshot) {
            // final notificationAlreadyEnabled = snapshot.data?[0] ?? false;
            // final geolocationAlreadyEnabled = snapshot.data?[1] ?? false;

            return PageView(
                controller: _onboardingController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  OnboardingExplanation(
                    title: widget.introPage.title,
                    imageUrl: widget.introPage.imageUrl,
                    paragraph: widget.introPage.paragraph,
                    onNext: widget.introPage.onNext ?? _onboardingNextPage,
                    buttonText: widget.introPage.introButtonText,
                  ),
                  _buildWalkthroughIntroSequence(),
                  ...widget.permissionSequence?.map((e) => OnboardingNotification(
                      title: e.title,
                      imageUrl: e.imageUrl,
                      onActivateLater: _onboardingNextPage,
                      paragraph: e.paragraph,
                      onActivate: _validatePermission,
                      buttonsText: ButtonsText(activate: "Activer", rememberLater: "Rappeller plus tard"),
                      permissionType: e.permissionType
                  )).toList() ?? []
                ]);
          }),
    );
  }

  Widget _buildWalkthroughIntroSequence() {
    return Builder(
      builder: (context) => IntroductionScreen(
        globalBackgroundColor: Theme.of(context).backgroundColor,
        isTopSafeArea: true,
        dotsDecorator: DotsDecorator(
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.primary,
        ),
        pages: [
          if (widget.introductionSequence != null)
            for (var i = 0; i < widget.introductionSequence!.length; i++)
              PageViewModel(
                image: Image.asset(widget.introductionSequence![i].imageUrl),
                titleWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: widget.introductionSequence![i].title,
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
                  child: TextAccentPunctuation(
                    text: widget.introductionSequence![i].paragraph,
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
          widget.buttonsText?.skip ?? "Skip",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
        ),
        next: Text(
          widget.buttonsText?.next ?? "Next",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
        ),
        done: Text(
          widget.buttonsText?.done ?? "Next",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
        ),
        animationDuration: 250,
        onDone: widget.onDone ?? _onboardingNextPage,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  void _onboardingNextPage() {
    _onboardingController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
    if(_onboardingController.page! >= length-1){
      Navigator.pop(context);
    }
  }

  void _validatePermission(PermissionType permission) async {
    PermissionSelector(permission).permissionSelect();
    _onboardingNextPage();
  }
}

class NiceOnboarding extends StatefulWidget {
  final VoidCallback? onDone;
  final IntroPageConfiguration introPage;
  final List<IntroductionConfiguration>? introductionSequence;
  final List<NotificationConfiguration>? permissionSequence;
  final ButtonsText? buttonsText;
  final Widget child;

  NiceOnboarding({
    required this.introPage,
    this.introductionSequence,
    this.permissionSequence,
    this.onDone,
    this.buttonsText,
    required this.child
  });

  @override
  _NiceOnboardingState createState() =>
      _NiceOnboardingState();
}

class _NiceOnboardingState extends State<NiceOnboarding> {
  @override
  void initState() {
      if(NiceFlutterKitOnboardingConfig().onboardingCompleted) {
        Navigator.pop(context);
    }
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return onboardingPage(
        child: widget.child,
        onDone: widget.onDone,
        introPage: widget.introPage,
        introductionSequence: widget.introductionSequence,
        permissionSequence: widget.permissionSequence,
        buttonsText: widget.buttonsText,
      );
  }
}
