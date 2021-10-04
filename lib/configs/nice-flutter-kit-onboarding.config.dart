import 'package:shared_preferences/shared_preferences.dart';

class NiceFlutterKitOnboardingConfig {
  final String sharedPrefKey;
  static bool? _onboardingCompleted;
  late SharedPreferences _sharedPref;

  NiceFlutterKitOnboardingConfig({this.sharedPrefKey: "ONBOARDING_COMPLETED"});

  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
    _onboardingCompleted = await _sharedPref.getBool(sharedPrefKey) ?? false;
  }

  bool get onboardingCompleted {
    assert(_onboardingCompleted == null);
    return _onboardingCompleted!;
  }

  set onboardingCompleted(bool onboardingCompleted) {
    assert(_onboardingCompleted != null);
    _onboardingCompleted = onboardingCompleted;
    _sharedPref.setBool(sharedPrefKey, true);
  }
}
