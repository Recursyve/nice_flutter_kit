import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/onboarding/widgets/base-button.widget.dart';
import 'package:nice_flutter_kit/onboarding/widgets/text-accent-punctuation.widget.dart';


class OnboardingExplanation extends StatelessWidget {
  final VoidCallback onNext;
  final TextAccentPunctuation title;
  final String paragraph;
  final String imageUrl;
  final String buttonText;

  const OnboardingExplanation({
    required this.onNext,
    required this.title,
    required this.imageUrl,
    required this.paragraph,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                imageUrl,
                width: 300,
              ),
            ),
          ),
          TextAccentPunctuation(
              text: title.text,
              punctuation: title.punctuation,
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 20),
          Text(paragraph, textAlign: TextAlign.center),
          const SizedBox(height: 125),
          BaseButton(
            displayText: buttonText,
            padding: EdgeInsets.zero,
            onPressed: onNext,
            themeColors: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
