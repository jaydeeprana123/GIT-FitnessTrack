import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fitness_track/Screens/Authentication/ForgotPassword/view/forgot_password_view.dart';
import 'package:fitness_track/Screens/Authentication/Profile/view/change_password_view.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import '../../../../utils/password_text_field.dart';
import '../../../Enums/select_date_enum.dart';
import '../../../utils/helper.dart';
import '../controller/attendance_controller.dart';

class EmployeeAttendanceListView extends StatefulWidget {
  const EmployeeAttendanceListView({Key? key}) : super(key: key);

  @override
  State<EmployeeAttendanceListView> createState() =>
      _EmployeeAttendanceListViewState();
}

class _EmployeeAttendanceListViewState
    extends State<EmployeeAttendanceListView> {
  /// Initialize the controller
  AttendanceController controller = Get.put(AttendanceController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo(true);
      controller.getEmployeeAttendanceListAPI();
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: color_primary,

            titleSpacing: 0,
            automaticallyImplyLeading: true,
            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return  InkWell(
            //       onTap: (){
            //         Navigator.pop(context);
            //       },
            //       child: Container(
            //         margin: EdgeInsets.all(14),
            //         child: Image.asset(
            //           width: double.infinity,
            //           height: double.infinity,
            //           icon_staklist_logo,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     );
            //   },
            // ),

            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    "My Attendance",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: fontInterMedium),
                  ),
                ),
                Visibility(
                  visible: controller
                          .fromDateEditingController.value.text.isNotEmpty ||
                      controller.toDateEditingController.value.text.isNotEmpty,
                  child: InkWell(
                    onTap: () async {
                      controller.fromDateEditingController.value.clear();
                      controller.toDateEditingController.value.clear();

                      var now = DateTime.now();
                      var formatter = DateFormat('yyyy-MM-dd');
                      String todayDate = formatter.format(now);

                      controller.fromDateEditingController.value.text =
                          todayDate;
                      controller.toDateEditingController.value.text = todayDate;

                      controller.getEmployeeAttendanceListAPI();
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          icon_remove_date,
                          width: 18,
                          height: 18,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Text(" CLEAR DATE",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: fontInterRegular)),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Obx(
            () => Column(
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            DateTime? dateTime = await Helper()
                                .selectDateInYYYYMMDD(
                                    context, SelectDateEnum.all.outputVal);

                            setState(() {
                              controller.fromDateEditingController.value.text =
                                  getDateFormtYYYYMMDDOnly(
                                      (dateTime ?? DateTime(2023)).toString());
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey,
                                )),
                            child: Text(
                                controller.fromDateEditingController.value.text
                                        .isNotEmpty
                                    ? controller
                                        .fromDateEditingController.value.text
                                    : "From",
                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 14,
                                    fontFamily: fontInterSemiBold)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            DateTime? dateTime = await Helper()
                                .selectDateInYYYYMMDD(
                                    context, SelectDateEnum.all.outputVal);

                            setState(() {
                              controller.toDateEditingController.value.text =
                                  getDateFormtYYYYMMDDOnly(
                                      (dateTime ?? DateTime(2023)).toString());
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey,
                                )),
                            child: Text(
                                controller.toDateEditingController.value.text
                                        .isNotEmpty
                                    ? controller
                                        .toDateEditingController.value.text
                                    : "To",
                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 14,
                                    fontFamily: fontInterSemiBold)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.getEmployeeAttendanceListAPI();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 4, bottom: 4),
                          margin: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: color_primary,
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              )),
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: !controller.isLoading.value
                      ? (controller.employeeAttendanceList ?? []).isNotEmpty
                          ? Container(
                              padding: EdgeInsets.all(12),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                primary: false,
                                shrinkWrap: true,
                                itemCount:
                                    controller.employeeAttendanceList.length,
                                itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    color: Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.all(12),

                                      margin:
                                          EdgeInsets.only(left: 4, right: 4),
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(12),
                                      //     color: color_primary,
                                      //     border: Border.all(
                                      //       width: 0.5,
                                      //       color: text_color,
                                      //     )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          (controller
                                                          .loginResponseModel
                                                          .value
                                                          .data?[0]
                                                          .regularShiftApply ??
                                                      "0") !=
                                                  "1"
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          icon_branch,
                                                          height: 20,
                                                          width: 20,
                                                          color: color_primary,
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                            ((controller
                                                                    .employeeAttendanceList[
                                                                        index]
                                                                    .branchName ??
                                                                "")),
                                                            style: TextStyle(
                                                                color:
                                                                    color_primary,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    fontInterSemiBold)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      icon_calender_date_event,
                                                      height: 20,
                                                      width: 20,
                                                      color: text_color,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                        ((controller
                                                                .employeeAttendanceList[
                                                                    index]
                                                                .attendanceDate ??
                                                            "")),
                                                        style: TextStyle(
                                                            color: text_color,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                fontInterSemiBold)),
                                                  ],
                                                ),
                                              ),
                                              (controller
                                                              .employeeAttendanceList[
                                                                  index]
                                                              .attendanceType ??
                                                          "") ==
                                                      "1"
                                                  ? Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                          left: 12,
                                                          right: 12,
                                                          top: 5,
                                                          bottom: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.r),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors.red,
                                                          )),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                (controller
                                                                            .employeeAttendanceList[
                                                                                index]
                                                                            .shiftName ??
                                                                        "") +
                                                                    " - ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        fontInterSemiBold)),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                                "${controller.employeeAttendanceList[index].attendanceTypeName}" ??
                                                                    "",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        fontInterSemiBold)),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                          left: 12,
                                                          right: 12,
                                                          top: 5,
                                                          bottom: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.r),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Colors.green,
                                                          )),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                (controller
                                                                            .employeeAttendanceList[
                                                                                index]
                                                                            .shiftName ??
                                                                        "") +
                                                                    " - ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        fontInterSemiBold)),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                                "${controller.employeeAttendanceList[index].attendanceTypeName}" ??
                                                                    "",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        fontInterSemiBold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                icon_time,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                  ((controller
                                                          .employeeAttendanceList[
                                                              index]
                                                          .attendanceTime ??
                                                      "")),
                                                  style: TextStyle(
                                                      color: text_color,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterSemiBold)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("LATE TIME : ",
                                                  style: TextStyle(
                                                      color: text_color,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterRegular)),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  "${controller.employeeAttendanceList[index].lateTime ?? ""} ",
                                                  style: TextStyle(
                                                      color: text_color,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterSemiBold)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("OVER TIME : ",
                                                  style: TextStyle(
                                                      color: text_color,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterRegular)),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  "${controller.employeeAttendanceList[index].overTime ?? ""} ",
                                                  style: TextStyle(
                                                      color: text_color,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterSemiBold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                              ("No Data Available"),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: text_color,
                                  fontFamily: fontInterSemiBold),
                            ))
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                )
              ],
            ),
          )),
    );
  }
}
