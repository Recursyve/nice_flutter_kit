import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/onboarding/onboarding.dart';
import 'package:nice_flutter_kit/onboarding/widgets/base-button.widget.dart';
import 'package:nice_flutter_kit/onboarding/widgets/text-accent-punctuation.widget.dart';

class OnboardingNotification extends StatelessWidget {
  final TextAccentPunctuation title;
  final String paragraph;
  final String imageUrl;
  final ButtonsText? buttonsText;
  final Function onActivate;
  final VoidCallback onActivateLater;
  final PermissionType permissionType;

  const OnboardingNotification({
    required this.title,
    required this.imageUrl,
    required this.paragraph,
    this.buttonsText,
    required this.onActivate,
    required this.onActivateLater,
    required this.permissionType
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                imageUrl,
                width: 196,
              ),
            ),
          ),
          TextAccentPunctuation(
            text: title.text,
            punctuation: title.punctuation,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 54),
          Text(paragraph),
          const SizedBox(height: 54),
          BaseButton(
            displayText: buttonsText?.activate ?? "ACTIVATE",
            padding: EdgeInsets.zero,
            onPressed: _activate,
            themeColors: Theme
                .of(context)
                .colorScheme
                .secondary,
          ),
          const SizedBox(height: 20),
          BaseButton(
            displayText: buttonsText?.rememberLater ?? "REMEMBERLATER",
            padding: EdgeInsets.zero,
            onPressed: onActivateLater,
            themeColors: Theme
                .of(context)
                .backgroundColor,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );


  }
  void _activate() {
    this.onActivate(this.permissionType);
  }
}