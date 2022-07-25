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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: _buildImage(configuration.imageUrl),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(children: [
                configuration.title,
                const SizedBox(height: 20),
                Text(
                  configuration.paragraph,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(configuration.bottomButtonText),
                    onPressed: onNext,
                    style: ButtonStyle(
                      backgroundColor: ElevatedButton.styleFrom().backgroundColor,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    final ext = extension(imageUrl);
    switch (ext) {
      case ".svg":
        return SvgPicture.asset(imageUrl, width: 260);
      default:
        return Image.asset(configuration.imageUrl, width: 260);
    }
  }
}
