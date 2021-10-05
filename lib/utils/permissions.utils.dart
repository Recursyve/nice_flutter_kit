import 'package:geolocator/geolocator.dart';
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

  static Future<void> requestGpsLocalizationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
    }
  }

  static Future<void> requestNotificationPermission() async {
    await NiceFcmService.requestPermission();
  }
}
