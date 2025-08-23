

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

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCnbxPzkWwv8Lq3Uqp3xa1Vk81NmnShYi0",
            appId: "1:384476936311:ios:b904a332db074298fdae72",
            messagingSenderId: "384476936311",
            projectId: "fitnesstrack-3aa31"));
  } else {
    await Firebase.initializeApp( options: FirebaseOptions(
        apiKey: "AIzaSyB5xkozrs7wcBOZWSoeFMGsVxMCYk6kqR4",
        appId: "1:384476936311:android:36c712e4f06804dffdae72",
        messagingSenderId: "384476936311",
        projectId: "fitnesstrack-3aa31"));
  }
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(const MyApp());
  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });



  await PushNotificationsService().init();
  // LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  print("Handling a background message doctor: ${event.messageId}");
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCnbxPzkWwv8Lq3Uqp3xa1Vk81NmnShYi0",
            appId: "1:384476936311:ios:b904a332db074298fdae72",
            messagingSenderId: "384476936311",
            projectId: "fitnesstrack-3aa31"));
  } else {
    await Firebase.initializeApp( options: FirebaseOptions(
        apiKey: "AIzaSyB5xkozrs7wcBOZWSoeFMGsVxMCYk6kqR4",
        appId: "1:384476936311:android:36c712e4f06804dffdae72",
        messagingSenderId: "384476936311",
        projectId: "fitnesstrack-3aa31"));
  }

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
