import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:toastification/toastification.dart';

class NotificationService {
  static Future<String?> init() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      final NotificationSettings settings = await messaging.requestPermission(provisional: true);

      if (kDebugMode) {
        print('Notification status : ${settings.authorizationStatus.name}');
      }

      if (!kIsWeb && Platform.isIOS || Platform.isMacOS) {
        final String? apnsToken = await messaging.getAPNSToken();

        if (kDebugMode) {
          print('APNs Token : $apnsToken');
        }
      }

      final token = await messaging.getToken();

      if (kDebugMode) {
        print('Notification Token : $token');
      }

      return token;
    } catch (e) {
      toastification.show(
        title: Text(e.toString()),
      );
    }

    return null;
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    print(message.notification?.title);
  }
}
