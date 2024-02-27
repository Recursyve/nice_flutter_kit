import "package:nice_flutter_kit/nice_flutter_kit.dart";

class NiceConfig {
  static NiceApiConfig? defaultApiConfig;
  static NiceDataFilterConfig? dataFilterConfig;
  static NiceBaseCubitConfig? baseCubitConfig;
  static NiceLocalizationsConfig localizationsConfig = const NiceLocalizationsConfig();

  const NiceConfig._();

  static Future<void> setup({
    NiceApiConfig? defaultApiConfig,
    NiceDataFilterConfig? dataFilterConfig,
    NiceBaseCubitConfig? baseCubitConfig,
    NiceLocalizationsConfig? localizationsConfig,
  }) async {
    NiceConfig.defaultApiConfig = defaultApiConfig;
    NiceConfig.dataFilterConfig = dataFilterConfig;
    NiceConfig.baseCubitConfig = baseCubitConfig ?? NiceBaseCubitConfig();

    if (localizationsConfig != null) {
      NiceConfig.localizationsConfig = localizationsConfig;
    }
  }
}
