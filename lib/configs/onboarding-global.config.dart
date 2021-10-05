import 'package:shared_preferences/shared_preferences.dart';

class NiceOnboardingGlobalConfig {
  final String sharedPrefKey;
  late SharedPreferences _sharedPref;
  bool? _onboardingCompleted;

  NiceOnboardingGlobalConfig({this.sharedPrefKey: "ONBOARDING_COMPLETED"});

  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
    this._onboardingCompleted = _sharedPref.getBool(sharedPrefKey) ?? false;
  }

  bool get onboardingCompleted {
    assert(this._onboardingCompleted != null, "NiceOnboarding wasn't initialized, please provide NiceOnboardingConfig in main");
    return this._onboardingCompleted!;
  }

  set onboardingCompleted(bool onboardingCompleted) {
    assert(this._onboardingCompleted != null, "NiceOnboarding wasn't initialized, please provide NiceOnboardingConfig in main");
    this._onboardingCompleted = onboardingCompleted;
    _sharedPref.setBool(sharedPrefKey, true);
  }
}
