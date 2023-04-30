import "package:geolocator/geolocator.dart";
import "package:nice_flutter_kit/src/services/fcm.service.dart";

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
        return await isGpsLocalizationPermissionEnabled();
      case NicePermissionTypes.notification:
        return await isNotificationPermissionEnabled();
    }
  }

  static Future<void> requestGpsLocalizationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  static Future<bool> isGpsLocalizationPermissionEnabled() async {
    final gpsPermission = await Geolocator.checkPermission();

    return !(gpsPermission == LocationPermission.denied);
  }

  static Future<void> requestNotificationPermission() async {
    await NiceFcmService.requestPermission();
  }

  static Future<bool> isNotificationPermissionEnabled() {
    return NiceFcmService.isPermissionGranted();
  }
}
