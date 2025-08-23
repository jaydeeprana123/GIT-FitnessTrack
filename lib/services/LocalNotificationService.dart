import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(initializationSettings);
  }

  static void displayNotification(RemoteMessage message, String number) async {
    print("notification received");
    print(message.data.toString());

    try {
      final id = Random().nextInt(20000);
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "push_notification", "push_notification_channel",
            priority: Priority.high),
      );
      await _notificationsPlugin.show(
        id,
        message.notification!.title.toString() + number,
        message.notification!.body.toString(),
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {}
  }
}