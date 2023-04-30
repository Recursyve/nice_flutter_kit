import "dart:async";

import "package:firebase_messaging/firebase_messaging.dart";
import "package:notification_permissions/notification_permissions.dart";

class NiceFcmService {
  static Future<String?> get token => FirebaseMessaging.instance.getToken();

  static Future<void> init() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      unawaited(_onOpenWithInitialMessage(initialMessage));
    }

    if (!await isPermissionGranted()) {
      return;
    }

    FirebaseMessaging.onMessage.listen(_onMessage);
  }

  static Future<void> requestPermission() async {
    final permission = await NotificationPermissions.requestNotificationPermissions();
    if (const [
      PermissionStatus.granted,
      PermissionStatus.provisional,
    ].contains(permission)) {
      FirebaseMessaging.onMessage.listen(_onMessage);
    }
  }

  static Future<bool> isPermissionGranted() async {
    final permission = await NotificationPermissions.getNotificationPermissionStatus();
    return const [
      PermissionStatus.granted,
      PermissionStatus.provisional,
    ].contains(permission);
  }

  static Future<bool> isPermissionPermanentlyDenied() async {
    final permission = await NotificationPermissions.getNotificationPermissionStatus();
    return permission == PermissionStatus.denied;
  }

  static Future<void> _onOpenWithInitialMessage(RemoteMessage message) async {
    // TODO: handle notification that opened the app
  }

  static Future<void> _onMessage(RemoteMessage message) async {
    // TODO: handle in-app notification
  }
}
