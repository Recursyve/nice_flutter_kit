import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceOnboardingWelcomePage extends StatelessWidget {
  final NiceOnboardingWelcomeConfiguration configuration;
  final VoidCallback onNext;

  const NiceOnboardingWelcomePage({
    required this.configuration,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  configuration.imageUrl,
                  width: 300,
                ),
              ),
            ),
            configuration.title,
            const SizedBox(height: 20),
            Text(configuration.paragraph, textAlign: TextAlign.center),
            const SizedBox(height: 125),
            NiceButton(
              displayText: configuration.bottomButtonText,
              padding: EdgeInsets.zero,
              onPressed: onNext,
              themeColors: Theme.of(context).buttonTheme.colorScheme?.primary,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
