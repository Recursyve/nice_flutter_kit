import "package:nice_flutter_kit/configs/configs.dart";

class NiceFlutterKitConfig {
  static NiceFlutterKitDataFilterConfig? dataFilterConfig;
  static NiceFlutterKitApiConfig? defaultApiConfig;

  const NiceFlutterKitConfig._();

  static void setup({
    NiceFlutterKitDataFilterConfig? dataFilterConfig,
    NiceFlutterKitApiConfig? defaultApiConfig,
  }) {
    NiceFlutterKitConfig.dataFilterConfig = dataFilterConfig;
    NiceFlutterKitConfig.defaultApiConfig = defaultApiConfig;
  }
}
