import 'package:geolocator/geolocator.dart';
import 'package:nice_flutter_kit/configs/config.dart';
import 'package:nice_flutter_kit/onboarding/permission/onboarding-permission-sequence.configuration.dart';
import 'package:nice_flutter_kit/services/fcm.service.dart';

enum NicePermissionTypes { notification, gpsLocalization }

class NicePermissionUtils {
  static Future<void> requestPermission(NicePermissionTypes type) async {
    switch (type) {
      case NicePermissionTypes.gpsLocalization:
        await requestGpsLocalizationPermission();
        break;
      case NicePermissionTypes.notification:
        await requestNotificationPermission();
        break;
    }
  }

  static Future<bool> isPermissionEnabled(NicePermissionTypes type) async {
    switch (type) {
      case NicePermissionTypes.gpsLocalization:
        return await isGpsLocalizationEnabled();
      case NicePermissionTypes.notification:
        return await isNotificationEnabled();
    }
  }

  static Future<void> requestGpsLocalizationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  static Future<bool> isGpsLocalizationEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  static Future<void> requestNotificationPermission() async {
    await NiceFcmService.requestPermission();
  }

  static Future<bool> isNotificationEnabled() {
    return NiceFcmService.isPermissionGranted();
  }

  static List<NiceOnboardingPermissionConfiguration> removeAlreadyEnabledPermissionConfig(
      List<NiceOnboardingPermissionConfiguration> configurations,
  ) {
   configurations.removeWhere(
      (permission) => (NiceConfig.onboardingConfig!.isPermissionEnabled[permission.type]!),
    );
    return configurations;
  }
}
