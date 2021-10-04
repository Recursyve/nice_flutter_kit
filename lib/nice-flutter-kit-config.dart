import 'package:flutter/widgets.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class NiceFlutterKitDataFilterConfig {
  final Map<Type, dynamic Function(Map<String, dynamic>)> deserializers;

  const NiceFlutterKitDataFilterConfig({
    this.deserializers: const {},
  });

  bool canDeserialize<T>() => deserializers.containsKey(T);

  T deserialize<T>(Map<String, dynamic> json) {
    if (!canDeserialize<T>()) {
      throw "Unimplemented deserializer function for type ${T.toString()}";
    }

    return deserializers[T]!(json);
  }
}

class NiceFlutterKitApiConfig {
  final String url;

  const NiceFlutterKitApiConfig({
    required this.url,
  });
}

class NiceFlutterKitOnboardingConfig {
  final String sharedPrefKey;
  bool? _onboardingCompleted;
  late SharedPreferences _sharedPref;

  NiceFlutterKitOnboardingConfig({this.sharedPrefKey: "ONBOARDING_COMPLETED"});

  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
    _onboardingCompleted = _sharedPref.getBool(sharedPrefKey) ?? false;
  }

  bool get onboardingCompleted {
    assert(this._onboardingCompleted != null);
    return this._onboardingCompleted!;
  }

  set onboardingCompleted(bool onboardingCompleted) {
    assert(this._onboardingCompleted != null);
    this._onboardingCompleted = onboardingCompleted;
    _sharedPref.setBool(sharedPrefKey, true);
  }
}
