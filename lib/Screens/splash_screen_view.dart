import 'dart:async';
import 'dart:math';

import 'package:fitness_track/CommonWidgets/common_widget.dart';
import 'package:fitness_track/Screens/Authentication/Login/model/customer_login_response_model.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fitness_track/Screens/Authentication/Welcome/view/welcome_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Enums/user_type_enum.dart';
import '../Styles/my_colors.dart';
import '../Styles/my_icons.dart';
import '../utils/preference_utils.dart';
import '../utils/share_predata.dart';
import 'Authentication/Login/model/employee_login_response_model.dart';
import 'BottomNavigation/view/bottom_navigation_view.dart';
import 'Customer/CustomerBottomNavigation/view/customer_bottom_navigation_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with TickerProviderStateMixin {
  Position? _currentPosition;
  String? _currentAddress;

  @override
  void initState() {
    super.initState();

    initSharedPreference();


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            img_splash,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  void redirectOnPendingState() {
    Future.delayed(const Duration(seconds: 2), () async {
      String userType =
          await MySharedPref().getStringValue(SharePreData.keyUserType);

      printData("hhhuh", userType);

      if (userType == UserTypeEnum.employee.outputVal) {
        EmployeeLoginResponseModel? loginResponseModel = (await MySharedPref()
                .getEmployeeLoginModel(SharePreData.keySaveLoginModel))
            as EmployeeLoginResponseModel?;

        if (loginResponseModel != null) {
          Get.offAll(BottomNavigationView(selectTabPosition: 0));
        } else {
          Get.off(() => WelcomeScreenView());
        }
      } else if (userType == UserTypeEnum.member.outputVal) {
        CustomerLoginResponseModel? loginResponseModel = (await MySharedPref()
                .getCustomerLoginModel(SharePreData.keySaveLoginModel))
            as CustomerLoginResponseModel?;

        if (loginResponseModel != null) {
          Get.offAll(CustomerBottomNavigationView(selectTabPosition: 0));
        } else {
          Get.off(() => WelcomeScreenView());
        }
      } else {
        Get.off(() => WelcomeScreenView());
      }
    });
  }

   initSharedPreference() async{
    await MySharedPref.getInstance(); // 🔥 REQUIRED FOR RELEASE

    redirectOnPendingState();
  }

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //
  //    await snackBarLongTime(context, "Location services are disabled. Please enable the services");
  //
  //    Future.delayed(const Duration(milliseconds: 2000), () {
  //      Geolocator.openLocationSettings().then((value) => _getCurrentPosition());
  //
  //    });
  //
  //
  //
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       print("LocationPermission.denied aayo");
  //
  //       _showLocationPermissionAlertDialog(false, permission);
  //
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     print("LocationPermission.deniedForever aayo");
  //     _showLocationPermissionAlertDialog(true, permission);
  //
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text('Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }
  //
  //
  // Future<void> _getCurrentPosition() async {
  //   print("_getCurrentPosition method call");
  //
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return;
  //   redirectOnPendingState();
  //
  //
  //   // await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //   //     .then((Position position) {
  //   //   print("position lat " + position.latitude.toString());
  //   //   print("position long " + position.longitude.toString());
  //   //
  //   //   if (position != null) {
  //   //     redirectOnPendingState();
  //   //   }
  //   //
  //   //   setState(() => _currentPosition = position);
  //   // }).catchError((e) {
  //   //   debugPrint(e.toString());
  //   // });
  // }
  //
  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(position.latitude, position.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress =
  //       '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';
  //
  //       // String address ='${placemarks.first.name.isNotEmpty
  //       //     ? placemarks.first.name + 'first name , ' : ''}'
  //       //     '${placemarks.first.thoroughfare.isNotEmpty
  //       //     ? placemarks.first.thoroughfare + 'thoroughfare , ' : ''}'
  //       //     '${placemarks.first.subLocality.isNotEmpty
  //       //     ? placemarks.first.subLocality+ 'subLocality , ' : ''}'
  //       //     '${placemarks.first.locality.isNotEmpty
  //       //     ? placemarks.first.locality+ 'locality , ' : ''}'
  //       //     '${placemarks.first.subAdministrativeArea.isNotEmpty
  //       //     ? placemarks.first.subAdministrativeArea + ' subAdministrativeArea , ' : ''}'
  //       //     '${placemarks.first.postalCode??"".isNotEmpty
  //       //     ? placemarks.first.postalCode + ', ' : ''}'
  //       //     '${placemarks.first.administrativeArea.isNotEmpty
  //       //     ? placemarks.first.administrativeArea : ''}';
  //
  //       // print("adreess"+address);
  //       //
  //       // print("_currentAddress - " + _currentAddress);
  //
  //       if (placemarks.first.locality != null) {
  //         if ((placemarks.first.locality??"").toLowerCase() == "rajkot") {
  //           _showLocationAlertDialog();
  //         } else {
  //           redirectOnPendingState();
  //         }
  //       }
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }
  //
  // Future<void> _showLocationAlertDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Location Alert'),
  //         content: const SingleChildScrollView(
  //           child: Text(
  //               "Sorry!! You can not use this application in your location"),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               SystemNavigator.pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> _showLocationPermissionAlertDialog(
  //     bool isPermanentDenied, LocationPermission permission) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title:  Text('Location Permission'),
  //         content:  SingleChildScrollView(
  //           child: Text((isPermanentDenied
  //               ? "Location permissions are permanently denied, we cannot request permissions. Sorry!! "
  //               : "Location permissions are denied. ") +
  //               "You can not use this application without giving location permission"),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(isPermanentDenied ? 'Ok' : 'Give Permission'),
  //             onPressed: () async {
  //               Navigator.pop(context);
  //
  //               if (isPermanentDenied) {
  //                 SystemNavigator.pop();
  //               } else {
  //                 _getCurrentPosition();
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
