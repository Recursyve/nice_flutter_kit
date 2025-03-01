import "dart:async";

import "package:firebase_messaging/firebase_messaging.dart";

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
    final notificationSettings = await FirebaseMessaging.instance.requestPermission();
    final status = notificationSettings.authorizationStatus;
    if (status == AuthorizationStatus.authorized || status == AuthorizationStatus.provisional) {
      FirebaseMessaging.onMessage.listen(_onMessage);
    }
  }

  static Future<bool> isPermissionGranted() async {
    final notificationSettings = await FirebaseMessaging.instance.getNotificationSettings();
    final status = notificationSettings.authorizationStatus;
    return status == AuthorizationStatus.authorized || status == AuthorizationStatus.provisional;
  }

  static Future<bool> isPermissionPermanentlyDenied() async {
    final notificationSettings = await FirebaseMessaging.instance.getNotificationSettings();
    final status = notificationSettings.authorizationStatus;
    return status == AuthorizationStatus.denied;
  }

  static Future<void> _onOpenWithInitialMessage(RemoteMessage message) async {
    // TODO: handle notification that opened the app
  }

  static Future<void> _onMessage(RemoteMessage message) async {
    // TODO: handle in-app notification
  }
}
