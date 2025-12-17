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

// D:\StudioFlutterAllProject\GIT-FITNESS-TRACK\build\app\outputs\flutter-apk

class PushNotificationsService {
  PushNotificationsService._();
  static final PushNotificationsService _instance =
  PushNotificationsService._();
  factory PushNotificationsService() => _instance;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.displayNotification(message, "");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    debugPrint("FCM Token: ${await messaging.getToken()}");

    _initialized = true;
  }
}

