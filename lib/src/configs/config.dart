import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:nice_flutter_kit/src/configs/onboarding-global.config.dart";

class NiceConfig {
  static NiceApiConfig? defaultApiConfig;
  static NiceDataFilterConfig? dataFilterConfig;
  static NiceOnboardingGlobalConfig? onboardingConfig;
  static NiceBaseCubitConfig? baseCubitConfig;
  static NiceLocalizationsConfig localizationsConfig = const NiceLocalizationsConfig();

  const NiceConfig._();

  static Future<void> setup({
    NiceApiConfig? defaultApiConfig,
    NiceDataFilterConfig? dataFilterConfig,
    NiceOnboardingGlobalConfig? onboardingConfig,
    NiceBaseCubitConfig? baseCubitConfig,
    NiceLocalizationsConfig? localizationsConfig,
  }) async {
    NiceConfig.defaultApiConfig = defaultApiConfig;
    NiceConfig.dataFilterConfig = dataFilterConfig;
    NiceConfig.onboardingConfig = onboardingConfig;
    NiceConfig.baseCubitConfig = baseCubitConfig ?? NiceBaseCubitConfig();

    if (localizationsConfig != null) {
      NiceConfig.localizationsConfig = localizationsConfig;
    }
  }
}
