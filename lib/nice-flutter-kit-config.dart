import "package:nice_flutter_kit/configs/configs.dart";

class NiceFlutterKitConfig {
  static NiceFlutterKitDataFilterConfig? dataFilterConfig;
  static NiceFlutterKitApiConfig? defaultApiConfig;
  static NiceFlutterKitOnboardingConfig? onboardingConfig;

  const NiceFlutterKitConfig._();

  static Future<void> setup({
    NiceFlutterKitDataFilterConfig? dataFilterConfig,
    NiceFlutterKitApiConfig? defaultApiConfig,
    NiceFlutterKitOnboardingConfig? onboardingConfig,
  }) async {
    NiceFlutterKitConfig.dataFilterConfig = dataFilterConfig;
    NiceFlutterKitConfig.defaultApiConfig = defaultApiConfig;
    NiceFlutterKitConfig.onboardingConfig = onboardingConfig;
    await NiceFlutterKitConfig.onboardingConfig!.init();
  }
}

