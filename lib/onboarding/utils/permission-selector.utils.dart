import 'package:geolocator/geolocator.dart';
import 'package:nice_flutter_kit/onboarding/onboarding.dart';
import 'package:nice_flutter_kit/onboarding/services/fcm.service.dart';


class PermissionSelector {
  late PermissionType permissionType;

  PermissionSelector(PermissionType type){
    this.permissionType = type;
  }

  void permissionSelect() async {
    switch(this.permissionType){
      case PermissionType.gpsLocalization:
        var permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied){
          await Geolocator.openAppSettings();
        }
        break;
      case PermissionType.notification:
        var permission = await FcmService.requestPermission();
        break;
    }
    return;
  }
}