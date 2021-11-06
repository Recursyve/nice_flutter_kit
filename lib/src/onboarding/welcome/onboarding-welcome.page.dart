import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
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
                child: _buildImage(configuration.imageUrl),
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

  Widget _buildImage(String imageUrl) {
    final ext = extension(imageUrl);
    switch (ext) {
      case ".svg":
        return SvgPicture.asset(imageUrl, width: 300);
      default:
        return Image.asset(configuration.imageUrl, width: 300);
    }
  }
}
