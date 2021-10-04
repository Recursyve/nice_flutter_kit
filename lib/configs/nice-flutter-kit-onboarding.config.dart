import 'package:shared_preferences/shared_preferences.dart';

class NiceFlutterKitOnboardingConfig {
  final String sharedPrefKey;
  bool? _onboardingCompleted;
  late SharedPreferences _sharedPref;

  NiceFlutterKitOnboardingConfig({this.sharedPrefKey: "ONBOARDING_COMPLETED"});

  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
    this._onboardingCompleted = _sharedPref.getBool(sharedPrefKey) ?? false;
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
