import 'dart:async';

import 'package:fitness_track/Enums/attendance_type_status_enum.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_font.dart';
import '../../../Utils/preference_utils.dart';
import '../../../Utils/share_predata.dart';
import '../../BottomNavigation/controller/bottom_navigation_controller.dart';
import '../../Holidays/view/holiday_list_view.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  /// Initialize the controller
  DashboardController dashboardController = Get.put(DashboardController());
  BottomNavigationController bottomNavController =
      Get.find<BottomNavigationController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await dashboardController.getUserInfo();
      bottomNavController.attendanceType.value =
          AttendanceTypeEnum.all.outputVal;
      Timer(Duration(seconds: 1), () {
        dashboardController.callDashboardCounterAPI();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => Stack(
          children: [
            (dashboardController.dashboardCounterModel.value.data ?? [])
                    .isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Get.to(HolidayListView());
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(12),
                                  padding: EdgeInsets.only(bottom: 36, top: 36),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: text_color),
                                      color: light_purpal_196461fb,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16.r),
                                          topLeft: Radius.circular(16.r),
                                          bottomLeft: Radius.circular(16.r),
                                          bottomRight: Radius.circular(16.r))),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          dashboardController
                                                  .dashboardCounterModel
                                                  .value
                                                  .data?[0]
                                                  .holidays ??
                                              "0",
                                          style: TextStyle(
                                              fontFamily: fontInterSemiBold,
                                              color: text_color,
                                              fontSize: 24.sp),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Holidays",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: fontInterRegular,
                                              color: text_color,
                                              fontSize: 14.sp),
                                        ),
                                      ])),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                bottomNavController.attendanceType.value =
                                    AttendanceTypeEnum.lateMark.outputVal;
                                bottomNavController.currentIndex.value = 3;
                              },
                              child: Container(
                                  margin: EdgeInsets.all(12),
                                  padding: EdgeInsets.only(bottom: 36, top: 36),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: text_color),
                                      color: light_orange_fc9875,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16.r),
                                          topLeft: Radius.circular(16.r),
                                          bottomLeft: Radius.circular(16.r),
                                          bottomRight: Radius.circular(16.r))),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          dashboardController
                                                  .dashboardCounterModel
                                                  .value
                                                  .data?[0]
                                                  .lateMark ??
                                              "0",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: fontInterSemiBold,
                                              color: text_color,
                                              fontSize: 24.sp),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Late Mark",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: fontInterRegular,
                                              color: text_color,
                                              fontSize: 14.sp),
                                        ),
                                      ])),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                bottomNavController.attendanceType.value =
                                    AttendanceTypeEnum.overTime.outputVal;
                                bottomNavController.currentIndex.value = 3;
                              },
                              child: Container(
                                  margin: EdgeInsets.all(12),
                                  padding: EdgeInsets.only(bottom: 36, top: 36),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: text_color),
                                      color: light_green_11199a8e,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16.r),
                                          topLeft: Radius.circular(16.r),
                                          bottomLeft: Radius.circular(16.r),
                                          bottomRight: Radius.circular(16.r))),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          dashboardController
                                                  .dashboardCounterModel
                                                  .value
                                                  .data?[0]
                                                  .overTime ??
                                              "0",
                                          style: TextStyle(
                                              fontFamily: fontInterSemiBold,
                                              color: text_color,
                                              fontSize: 24.sp),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Over Time",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: fontInterRegular,
                                              color: text_color,
                                              fontSize: 14.sp),
                                        ),
                                      ])),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                bottomNavController.attendanceType.value =
                                    AttendanceTypeEnum.absent.outputVal;
                                bottomNavController.currentIndex.value = 3;
                              },
                              child: Container(
                                  margin: EdgeInsets.all(12),
                                  padding: EdgeInsets.only(bottom: 36, top: 36),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: text_color),
                                      color: light_red_f1d6d6,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16.r),
                                          topLeft: Radius.circular(16.r),
                                          bottomLeft: Radius.circular(16.r),
                                          bottomRight: Radius.circular(16.r))),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          dashboardController
                                                  .dashboardCounterModel
                                                  .value
                                                  .data?[0]
                                                  .absent ??
                                              "0",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: fontInterSemiBold,
                                              color: text_color,
                                              fontSize: 24.sp),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Absent",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: fontInterRegular,
                                              color: text_color,
                                              fontSize: 14.sp),
                                        ),
                                      ])),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : SizedBox(),
            if (dashboardController.isLoading.value)
              Center(child: CircularProgressIndicator(),)
          ],
        ),
      ),
    ));
  }
}
