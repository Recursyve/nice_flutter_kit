import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceOnboardingGlobalConfig {
  final String? sharedPrefKey;
  final Set<NicePermissionTypes>? permissions;
  final bool debug;

  @Deprecated("This config will be removed in the next major version. Use NiceOnboardingConfiguration instead.")
  NiceOnboardingGlobalConfig({
    this.sharedPrefKey = "ONBOARDING_COMPLETED",
    this.permissions,
    this.debug = false,
  });
}
