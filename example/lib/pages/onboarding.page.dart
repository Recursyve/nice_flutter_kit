import "package:example/pages/common/base.page.dart";
import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Onboarding",
      child: NiceOnboarding(
        configuration: const NiceOnboardingConfiguration(
          welcome: NiceOnboardingWelcomeConfiguration(
            imageUrl: "assets/bacon.png",
            title: NiceTextAccentPunctuation(
              text: "Bacon ipsum",
              punctuation: ".",
            ),
            paragraph:
                "Bacon ipsum dolor amet kevin pork belly biltong, burgdoggen frankfurter pastrami t-bone meatball bacon hamburger turkey.",
            bottomButtonText: "Ipsum",
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () => NiceConfig.onboardingConfig!.onboardingCompleted = false,
            child: const Text("Reset onboarding completion"),
          ),
        ),
      ),
    );
  }
}
