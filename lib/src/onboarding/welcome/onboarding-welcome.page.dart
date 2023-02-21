import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

class NiceOnboardingWelcomePage extends StatelessWidget {
  static const double buttonHeight = 100;

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
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height - buttonHeight) * 0.6,
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildImage(configuration.imageUrl),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 40),
                        configuration.title,
                        const SizedBox(height: 20),
                        Text(
                          configuration.paragraph,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(configuration.bottomButtonText),
                onPressed: onNext,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
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
