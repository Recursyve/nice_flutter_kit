import 'package:nice_flutter_kit/utils/permissions.utils.dart';
import 'package:nice_flutter_kit/widgets/nice-text-accent-punctuation.widget.dart';

class NiceOnboardingPermissionConfiguration {
  final NicePermissionTypes type;
  final String imageUrl;
  final NiceTextAccentPunctuation title;
  final String paragraph;
  final String activate;
  final String activateLater;

  const NiceOnboardingPermissionConfiguration({
    required this.type,
    required this.imageUrl,
    required this.title,
    required this.paragraph,
    required this.activate,
    required this.activateLater,
  });
}

class OnboardingPermissionSequenceConfiguration {
  final List<NiceOnboardingPermissionConfiguration> configurations;

  const OnboardingPermissionSequenceConfiguration({
    required this.configurations,
  }) : assert(configurations.length > 0);
}
