import 'package:nice_flutter_kit/configs/api.config.dart';
import 'package:nice_flutter_kit/configs/data-filter.config.dart';
import 'package:nice_flutter_kit/configs/onboarding-global.config.dart';

class NiceConfig {
  static NiceApiConfig? defaultApiConfig;
  static NiceDataFilterConfig? dataFilterConfig;
  static NiceOnboardingGlobalConfig? onboardingConfig;

  const NiceConfig._();

  static Future<void> setup({
    NiceApiConfig? defaultApiConfig,
    NiceDataFilterConfig? dataFilterConfig,
    NiceOnboardingGlobalConfig? onboardingConfig,
  }) async {
    NiceConfig.defaultApiConfig = defaultApiConfig;
    NiceConfig.dataFilterConfig = dataFilterConfig;
    NiceConfig.onboardingConfig = onboardingConfig;
    if (NiceConfig.onboardingConfig != null) {
      //hardcoded permissionsTypes for now
      await NiceConfig.onboardingConfig!.init();
    }
  }
}
