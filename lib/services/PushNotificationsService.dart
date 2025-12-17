import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_track/Screens/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../Networks/api_endpoint.dart';
import '../Networks/api_response.dart';
import '../Networks/model/base_model.dart';
import '../Utils/share_predata.dart';
import '../utils/preference_utils.dart';
import 'LocalNotificationService.dart';

class PushNotificationsService {
  PushNotificationsService._();

  factory PushNotificationsService() => _instance;

  static final PushNotificationsService _instance =
      PushNotificationsService._();

  late FirebaseMessaging _firebaseMessaging;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    // ✅ Initialize ONLY after Firebase.initializeApp()
    _firebaseMessaging = FirebaseMessaging.instance;

    await _firebaseMessaging.requestPermission();

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        LocalNotificationService.displayNotification(message, "");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      LocalNotificationService.displayNotification(event, "");
      debugPrint("message title ${event.notification?.title}");
      debugPrint("message body ${event.notification?.body}");
      debugPrint("event.data -- > ${event.data}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // navigation if needed
    });

    String? fcmToken = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $fcmToken");

    _initialized = true;
  }
}
