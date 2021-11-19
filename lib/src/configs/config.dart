import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:nice_flutter_kit/src/configs/base-cubit.config.dart';

class NiceConfig {
  static NiceApiConfig? defaultApiConfig;
  static NiceDataFilterConfig? dataFilterConfig;
  static NiceOnboardingGlobalConfig? onboardingConfig;
  static NiceBaseCubitConfig? baseCubitConfig;

  const NiceConfig._();

  static Future<void> setup({
    NiceApiConfig? defaultApiConfig,
    NiceDataFilterConfig? dataFilterConfig,
    NiceOnboardingGlobalConfig? onboardingConfig,
    NiceBaseCubitConfig? baseCubitConfig,
  }) async {
    NiceConfig.defaultApiConfig = defaultApiConfig;
    NiceConfig.dataFilterConfig = dataFilterConfig;
    NiceConfig.onboardingConfig = onboardingConfig;
    if (NiceConfig.onboardingConfig != null) {
      //hardcoded permissionsTypes for now
      await NiceConfig.onboardingConfig!.init();
    }
    NiceConfig.baseCubitConfig = baseCubitConfig ?? NiceBaseCubitConfig();
  }
}
