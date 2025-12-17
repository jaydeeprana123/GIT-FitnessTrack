import 'package:fitness_track/Screens/Authentication/Login/view/employee_login_via_otp_view.dart';
import 'package:fitness_track/services/LocalNotificationService.dart';
import 'package:fitness_track/services/PushNotificationsService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fitness_track/Screens/splash_screen_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // try {
  //   if (Platform.isIOS) {
  //     await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //         apiKey: "AIzaSyCnbxPzkWwv8Lq3Uqp3xa1Vk81NmnShYi0",
  //         appId: "1:384476936311:ios:b904a332db074298fdae72",
  //         messagingSenderId: "384476936311",
  //         projectId: "fitnesstrack-3aa31",
  //       ),
  //     );
  //   } else {
  //     await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //         apiKey: "AIzaSyB5xkozrs7wcBOZWSoeFMGsVxMCYk6kqR4",
  //         appId: "1:384476936311:android:36c712e4f06804dffdae72",
  //         messagingSenderId: "384476936311",
  //         projectId: "fitnesstrack-3aa31",
  //       ),
  //     );
  //   }
  // } catch (e) {
  //   debugPrint("Firebase init failed: $e");
  // }

  // Register background handler FIRST
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Call AFTER Firebase init
  await PushNotificationsService().init();

  runApp(const MyApp());
  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  print("Handling a background message doctor: ${event.messageId}");

  await Firebase.initializeApp();

  // if (Platform.isIOS) {
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //           apiKey: "AIzaSyCnbxPzkWwv8Lq3Uqp3xa1Vk81NmnShYi0",
  //           appId: "1:384476936311:ios:b904a332db074298fdae72",
  //           messagingSenderId: "384476936311",
  //           projectId: "fitnesstrack-3aa31"));
  // } else {
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //           apiKey: "AIzaSyB5xkozrs7wcBOZWSoeFMGsVxMCYk6kqR4",
  //           appId: "1:384476936311:android:36c712e4f06804dffdae72",
  //           messagingSenderId: "384476936311",
  //           projectId: "fitnesstrack-3aa31"));
  // }

  // LocalNotificationService.initialize();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(
    "notification",
    event.toMap().toString(),
  );
  // Get.to(SplashScreenView());
  // print("message recieved");
  print(event.notification?.body ?? "");
  print("event.data -- > ${event.data}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var localizationDelegate = LocalizedApp.of(context).delegate;
    // changeLocale(context, "ru");
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // supportedLocales: localizationDelegate.supportedLocales,
          // locale: localizationDelegate.currentLocale,
          title: 'FTG',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          home: const SplashScreenView(),

          // home: const LatestHomepageTest(),

          // home: MyHomePage(title: "Mine Astro",),
          //  home: const ListScreen(),

          //  home: const HealthPackageDetailPage(),
        );
      },
    );
  }
}
