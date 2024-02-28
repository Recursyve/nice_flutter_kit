import "package:permission_handler/permission_handler.dart";

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
    await Permission.location.request();
  }

  static Future<bool> isGpsLocalizationPermissionEnabled() async {
    return Permission.location.isGranted;
  }

  static Future<void> requestNotificationPermission() async {
    await Permission.notification.request();
  }

  static Future<bool> isNotificationPermissionEnabled() {
    return Permission.notification.isGranted;
  }
}
