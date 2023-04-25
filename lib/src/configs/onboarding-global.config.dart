import "dart:collection";

import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:shared_preferences/shared_preferences.dart";

class NiceOnboardingGlobalConfig {
  final String sharedPrefKey;
  late SharedPreferences _sharedPref;
  bool? _onboardingCompleted;
  late HashMap<NicePermissionTypes, bool> isPermissionEnabled = HashMap<NicePermissionTypes, bool>();
  final Set<NicePermissionTypes>? permissions;
  final bool debug;

  NiceOnboardingGlobalConfig({
    this.sharedPrefKey = "ONBOARDING_COMPLETED",
    this.permissions,
    this.debug = false,
  });

  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
    _onboardingCompleted = _sharedPref.getBool(sharedPrefKey) ?? false;

    if (debug) {
      _onboardingCompleted = false;
    }

    for (final permission in (permissions ?? {}).toList()) {
      isPermissionEnabled[permission] = await NicePermissionUtils.isPermissionEnabled(permission);
    }
  }

  bool get onboardingCompleted {
    assert(
      _onboardingCompleted != null,
      "NiceOnboarding wasn't initialized, please provide NiceOnboardingConfig in main",
    );
    return _onboardingCompleted!;
  }

  set onboardingCompleted(bool onboardingCompleted) {
    assert(
      _onboardingCompleted != null,
      "NiceOnboarding wasn't initialized, please provide NiceOnboardingConfig in main",
    );
    _onboardingCompleted = onboardingCompleted;
    _sharedPref.setBool(sharedPrefKey, true);
  }
}
