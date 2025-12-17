import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:fitness_track/CommonWidgets/not_at_location_dialog.dart';
import 'package:fitness_track/Screens/Dashboard/model/dashboard_counter_model.dart';
import 'package:fitness_track/Utils/share_predata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fitness_track/Screens/Authentication/ForgotPassword/view/forgot_password_view.dart';
import 'package:fitness_track/Screens/Authentication/Profile/view/change_password_view.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import '../../../Utils/preference_utils.dart';
import '../controller/shift_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DayInOutView extends StatefulWidget {
  final String shiftId;
  final String branchId;
  final String status;

  DayInOutView({
    Key? key,
    required this.shiftId,
    required this.branchId,
    required this.status,
  }) : super(key: key);

  @override
  State<DayInOutView> createState() => _DayInOutViewState();
}

class _DayInOutViewState extends State<DayInOutView> {
  /// Initialize the controller
  ShiftController controller = Get.find<ShiftController>();
  Position? _currentPosition;
  String? _currentAddress;
  var distanceFromGym = -1.0;

  @override
  void initState() {
    // _firebaseMessaging.getToken().then((token) {
    //   controller.deviceToken = token;
    //   printData(runtimeType.toString(), token.toString());
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.isButtonHide.value = false;
      controller.imagePath.value = "";
      controller.dashboardData.value = await MySharedPrefNew()
              .getDashboardData(SharePreData.keyDashboardData) ??
          DashboardData();
      controller.statusResponse.value = widget.status;

      controller.isBackClose.value = false;
      setState(() {});

      _getCurrentPosition("");

      //  controller.getLoginStatusAPI(context, widget.shiftId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: color_primary, // navigation bar color
      statusBarColor: color_primary, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return Obx(() => PopScope(
          canPop: (controller.isBackClose.value) ? false : true,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Log In/Out",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: fontInterSemiBold),
                      ),
                    ),
                  ],
                ),
                backgroundColor: color_primary,
              ),

              /// Here I change Temp
              body: (distanceFromGym != -1) && (distanceFromGym > 1)
                  ? (controller.isLoading.value)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      :

                      Center(
                          child: CommonGreenButton(
                              "You are not at location. Please try again!", () {
                            controller.isLoading.value = true;
                            _getCurrentPosition("");
                          }, color_primary),
                        )
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              controller.statusResponse.value == "2"
                                  ? Center(
                                      child: Text(
                                      "Your attendance is submited",
                                      style: TextStyle(fontSize: 18),
                                    ))
                                  : Center(
                                      child: InkWell(
                                        onTap: () async {
                                          controller.isLoading.value = true;

                                          controller.imagePath.value =
                                              await openCamera(context);

                                          controller.isLoading.value = false;

                                          printData(
                                              "controller.imagePath.value",
                                              controller.imagePath.value);
                                          setState(() {});
                                        },
                                        child: (controller
                                                .imagePath.value.isNotEmpty)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(90.r),
                                                child: Image.file(
                                                  imageFile,
                                                  fit: BoxFit.fill,
                                                  height: 130,
                                                  width: 130,
                                                ),
                                              )
                                            : Container(
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90.r),
                                                      child: DottedBorder(
                                                        dashPattern: [6, 3],
                                                        strokeWidth: 1.5,
                                                        color: hint_txt_909196,
                                                        borderType:
                                                            BorderType.Circle,
                                                        radius:
                                                            Radius.circular(50),
                                                        child: Container(
                                                          height: 130,
                                                          width: 130,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color:
                                                                      line_gray_e2e2e6),
                                                          child: SizedBox(),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      "Add Your Photo",
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xff3e4046),
                                                          fontFamily:
                                                              fontInterSemiBold,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                              SizedBox(
                                height: 26,
                              ),
                              controller.statusResponse.value == "0"
                                  ? Visibility(
                                      visible: !controller.isButtonHide.value,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 38.0, right: 38),
                                          child:
                                              CommonGreenButton("SHIFT IN", () {
                                            FocusScope.of(context).unfocus();

                                            checkNet(context).then((value) {
                                              if (controller
                                                  .imagePath.isNotEmpty) {
                                                controller.isLoading.value =
                                                    true;
                                                controller.isBackClose.value =
                                                    true;
                                                controller.isButtonHide.value =
                                                    true;

                                                printData("distanceFromGym",
                                                    distanceFromGym.toString());

                                                if (distanceFromGym == -1) {
                                                  _getCurrentPosition("1");
                                                } else {
                                                  printData(
                                                      "mobileeee",
                                                      controller
                                                              .loginResponseModel
                                                              .value
                                                              .data?[0]
                                                              .mobile ??
                                                          "");

                                                  if (distanceFromGym < 1) {
                                                    controller.callDayInOutAPI(
                                                        widget.shiftId,
                                                        widget.branchId,
                                                        "1");
                                                  } else {
                                                    if (controller
                                                            .loginResponseModel
                                                            .value
                                                            .data?[0]
                                                            .mobile ==
                                                        "9737388786") {
                                                      printData(
                                                          "My Mobile",
                                                          controller
                                                                  .loginResponseModel
                                                                  .value
                                                                  .data?[0]
                                                                  .mobile ??
                                                              "");
                                                      controller
                                                          .callDayInOutAPI(
                                                              widget.shiftId,
                                                              widget.branchId,
                                                              "1");
                                                    } else {
                                                      controller.isBackClose
                                                          .value = false;
                                                      controller.isLoading
                                                          .value = false;

                                                      snackBar(context,
                                                          "You can not give attendance");

                                                      DateTime now =
                                                          DateTime.now();
                                                      String currentTime =
                                                          DateFormat('HH:mm:ss')
                                                              .format(now);
                                                      String currentDate =
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(now);
                                                      String day =
                                                          DateFormat('EEEE')
                                                              .format(now);

                                                      printData("current ",
                                                          "$currentDate  $currentTime  $day");
                                                    }
                                                  }
                                                }

                                                // controller.callDayInOutAPI(
                                                //     context, widget.shiftId, widget.branchId, "1");
                                                // _getCurrentPosition("1");
                                              } else {
                                                snackBar(context,
                                                    "Take your photo first");
                                              }
                                            });
                                          }, button_Color),
                                        ),
                                      ),
                                    )
                                  : controller.statusResponse.value == "1"
                                      ? Visibility(
                                          visible:
                                              !controller.isButtonHide.value,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 38.0, right: 38),
                                              child: CommonGreenButton(
                                                  "SHIFT OUT", () {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                checkNet(context).then((value) {
                                                  if (controller
                                                      .imagePath.isNotEmpty) {
                                                    controller.isLoading.value =
                                                        true;
                                                    controller.isBackClose
                                                        .value = true;
                                                    controller.isButtonHide
                                                        .value = true;

                                                    if (distanceFromGym == -1) {
                                                      _getCurrentPosition("2");
                                                    } else {
                                                      if (distanceFromGym < 1) {
                                                        controller
                                                            .callDayInOutAPI(
                                                                widget.shiftId,
                                                                widget.branchId,
                                                                "2");
                                                      } else {
                                                        if (controller
                                                                .loginResponseModel
                                                                .value
                                                                .data?[0]
                                                                .mobile ==
                                                            "9737388786") {
                                                          printData(
                                                              "My Mobile",
                                                              controller
                                                                      .loginResponseModel
                                                                      .value
                                                                      .data?[0]
                                                                      .mobile ??
                                                                  "");
                                                          controller
                                                              .callDayInOutAPI(
                                                                  widget
                                                                      .shiftId,
                                                                  widget
                                                                      .branchId,
                                                                  "2");
                                                        } else {
                                                          controller.isBackClose
                                                              .value = false;
                                                          controller.isLoading
                                                              .value = false;

                                                          snackBar(context,
                                                              "You can not give attendance");

                                                          DateTime now =
                                                              DateTime.now();
                                                          String currentTime =
                                                              DateFormat(
                                                                      'HH:mm:ss')
                                                                  .format(now);
                                                          String currentDate =
                                                              DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(now);
                                                          String day =
                                                              DateFormat('EEEE')
                                                                  .format(now);

                                                          printData("current ",
                                                              "$currentDate  $currentTime  $day");
                                                        }
                                                      }
                                                    }
                                                  } else {
                                                    snackBar(context,
                                                        "Take your photo first");
                                                  }
                                                });
                                              }, button_Color),
                                            ),
                                          ),
                                        )
                                      : controller.statusResponse.value == "1"
                                          ? SizedBox()
                                          : SizedBox(),
                            ],
                          ),
                        ),
                        controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox()
                      ],
                    ),
            ),
          ),
        ));
  }

  Future<bool> _handleLocationPermission(String attendanceType) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Yor Location services are disabled. Without location service you can not submit the attendance. Please enable the services')));

      controller.isLoading.value = false;

      Timer(Duration(seconds: 5), () {
        Geolocator.openLocationSettings();
      });

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("LocationPermission.denied aayo");

        _showLocationPermissionAlertDialog(false, permission, attendanceType);

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("LocationPermission.deniedForever aayo");
      _showLocationPermissionAlertDialog(true, permission, attendanceType);

      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition(String attendanceType) async {
    print("_getCurrentPosition method call");

    final hasPermission = await _handleLocationPermission(attendanceType);
    if (!hasPermission) {
      controller.isLoading.value = false;
      controller.isButtonHide.value = false;
      controller.isBackClose.value = false;
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position? position) {
      if (position != null) {
        print("position lat ${position.latitude ?? 0}");
        print("position long ${position.longitude ?? 0}");

        print(
            "branch lat ${controller.dashboardData.value.branchLatData.toString()}");
        print(
            "branch long ${controller.dashboardData.value.branchLongData.toString()}");

        distanceFromGym = (calculateDistance(
            double.parse(
                controller.dashboardData.value.branchLatData.toString()),
            double.parse(
                controller.dashboardData.value.branchLongData.toString()),
            position.latitude,
            position.longitude));

        // snackBarLongTime(context,
        //     "Distance from gym is " + (distanceFromGym.toString()) + " Km");

        // if(distanceFromGym > 1){
        //   /// Show full-screen dialog for no internet
        //   controller.isLoading.value = false;
        //   Get.dialog(
        //     NotAtLocationDialog(
        //       onRetry: () {
        //         Get.back();// Close the dialog
        //         setState(() {
        //
        //         });
        //         _getCurrentPosition(attendanceType);// Retry API call
        //       },
        //     ),
        //     barrierDismissible: false,
        //   );
        // }


        if (attendanceType == "1" || attendanceType == "2") {
          if (distanceFromGym < 1 && distanceFromGym != -1) {
            DateTime now = DateTime.now();
            controller.currentTime = DateFormat('HH:mm:ss').format(now);
            printData("currecnt ", controller.currentTime);
            printData(
                "currecnt time when location get ", controller.currentTime);
            controller.callDayInOutAPI(
                widget.shiftId, widget.branchId, attendanceType);
          } else {
            if (controller.loginResponseModel.value.data?[0].mobile ==
                "9737388786") {
              printData("My Mobile",
                  controller.loginResponseModel.value.data?[0].mobile ?? "");
              controller.callDayInOutAPI(
                  widget.shiftId, widget.branchId, attendanceType);
            } else {
              controller.isBackClose.value = false;
              controller.isLoading.value = false;

              snackBar(context, "You can not give attendance");

              DateTime now = DateTime.now();
              String currentTime = DateFormat('HH:mm:ss').format(now);
              String currentDate = DateFormat('yyyy-MM-dd').format(now);
              String day = DateFormat('EEEE').format(now);

              printData("current ", "$currentDate  $currentTime  $day");
            }
          }
        } else {
          controller.isLoading.value = false;
        }

        if (distanceFromGym < 1 && distanceFromGym != -1) {
          DateTime now = DateTime.now();
          controller.currentTime = DateFormat('HH:mm:ss').format(now);
          printData("currecnt ", controller.currentTime);
          printData("currecnt time when location get ", controller.currentTime);
        }

        setState(() {});
        printData("distanceFromGym ", distanceFromGym.toString());
      }
    }).catchError((e) {
      controller.isLoading.value = false;
      debugPrint(e.toString());
    });
  }

  Future<void> _showLocationPermissionAlertDialog(bool isPermanentDenied,
      LocationPermission permission, String attendanceType) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission'),
          content: SingleChildScrollView(
            child: Text((isPermanentDenied
                    ? "Location permissions are permanently denied, we cannot request permissions. Sorry!! "
                    : "Location permissions are denied. ") +
                "You can not use this application without giving location permission"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(isPermanentDenied ? 'Ok' : 'Give Permission'),
              onPressed: () async {
                Navigator.pop(context);

                if (isPermanentDenied) {
                  SystemNavigator.pop();
                } else {
                  _getCurrentPosition(attendanceType);
                }
              },
            ),
          ],
        );
      },
    );
  }

//
  double calculateDistance(lat1, lon1, lat2, lon2) {
    printData("calculateDistance", lat1.toString());
    printData("calculateDistance", lon1.toString());
    printData("calculateDistance", lat2.toString());
    printData("calculateDistance", lon2.toString());
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    printData("calculate Data", (12742 * asin(sqrt(a))).toString());

    return 12742 * asin(sqrt(a));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.isLoading.value = false;
  }
}
