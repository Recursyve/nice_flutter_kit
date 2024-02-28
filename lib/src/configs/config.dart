import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceConfig {
  static NiceApiConfig? defaultApiConfig;
  static NiceDataFilterConfig? dataFilterConfig;
  @Deprecated("This config will be removed in the next major version. Use NiceOnboardingConfiguration instead.")
  static NiceOnboardingGlobalConfig? onboardingConfig;
  static NiceBaseCubitConfig? baseCubitConfig;
  static NiceLocalizationsConfig localizationsConfig = const NiceLocalizationsConfig();

  const NiceConfig._();

  static Future<void> setup({
    NiceApiConfig? defaultApiConfig,
    NiceDataFilterConfig? dataFilterConfig,
    @Deprecated("This config will be removed in the next major version. Use NiceOnboardingConfiguration instead.")
    NiceOnboardingGlobalConfig? onboardingConfig,
    NiceBaseCubitConfig? baseCubitConfig,
    NiceLocalizationsConfig? localizationsConfig,
  }) async {
    NiceConfig.defaultApiConfig = defaultApiConfig;
    NiceConfig.dataFilterConfig = dataFilterConfig;
    // ignore: deprecated_member_use_from_same_package
    NiceConfig.onboardingConfig = onboardingConfig;
    NiceConfig.baseCubitConfig = baseCubitConfig ?? NiceBaseCubitConfig();

    if (localizationsConfig != null) {
      NiceConfig.localizationsConfig = localizationsConfig;
    }
  }
}
