import 'dart:developer';

import 'package:fitness_track/Enums/leave_status_enum.dart';
import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_details_view.dart';
import 'package:fitness_track/Screens/LeaveManagement/view/add_leave_view.dart';
import 'package:fitness_track/Screens/LeaveManagement/view/edit_leave_view.dart';
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
import '../controller/leave_management_controller.dart';

class LeaveListView extends StatefulWidget {
  const LeaveListView({Key? key}) : super(key: key);

  @override
  State<LeaveListView> createState() => _LeaveListViewState();
}

class _LeaveListViewState extends State<LeaveListView> {
  /// Initialize the controller
  LeaveManagementController controller = Get.put(LeaveManagementController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
      controller.getLeaveListAPI();
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
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "My Leaves",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(AddLeaveView())
                      ?.then((value) => controller.getLeaveListAPI());
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon_add_plus_square_new,
                      height: 22,
                      width: 22,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text("Add Leave",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: fontInterRegular)),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Obx(() => Stack(
              children: [
                controller.leaveList.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: controller.leaveList.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(12),
                          //     color: color_primary,
                          //     border: Border.all(
                          //       width: 0.5,
                          //       color: Colors.white,
                          //     )),
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: Colors.white,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 0.5,
                                      color: devider_color,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        ((controller.leaveList[index]
                                                        .leaveStatusType ??
                                                    "0") ==
                                                LeaveStatusEnum.pending.outputVal)
                                            ? "Pending"
                                            : ((controller.leaveList[index]
                                                            .leaveStatusType ??
                                                        "0") ==
                                                    LeaveStatusEnum
                                                        .approve.outputVal)
                                                ? "Approve"
                                                : ((controller.leaveList[index]
                                                                .leaveStatusType ??
                                                            "0") ==
                                                        LeaveStatusEnum
                                                            .reject.outputVal)
                                                    ? "Reject"
                                                    : "Pending",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: ((controller.leaveList[index]
                                                            .leaveStatusType ??
                                                        "0") ==
                                                    LeaveStatusEnum
                                                        .pending.outputVal)
                                                ? Colors.orange
                                                : ((controller.leaveList[index]
                                                                .leaveStatusType ??
                                                            "0") ==
                                                        LeaveStatusEnum
                                                            .approve.outputVal)
                                                    ? Colors.green
                                                    : ((controller.leaveList[index]
                                                                    .leaveStatusType ??
                                                                "0") ==
                                                            LeaveStatusEnum
                                                                .reject.outputVal)
                                                        ? Colors.red
                                                        : Colors.orange,
                                            fontFamily: fontInterSemiBold),
                                      ),
                                    ),
                                    for (int i = 0;
                                        i <
                                            (controller.leaveList[index]
                                                        .leaveDataList ??
                                                    [])
                                                .length;
                                        i++)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                icon_calender_date_event,
                                                height: 18,
                                                width: 18,
                                                color: text_color,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                  getDateOnly((controller
                                                              .leaveList
                                                              .value[index]
                                                              .leaveDataList?[i]
                                                              .leaveDate ??
                                                          DateTime(2024))
                                                      .toString()),
                                                  style: TextStyle(
                                                      color: hint_txt_909196,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterSemiBold)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Text("SHIFT : ",
                                                  style: TextStyle(
                                                      color: text_color,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterRegular)),
                                              Text(
                                                  controller
                                                          .leaveList
                                                          .value[index]
                                                          .leaveDataList?[i]
                                                          .shiftName ??
                                                      "",
                                                  style: TextStyle(
                                                      color: text_color,
                                                      fontSize: 13,
                                                      fontFamily:
                                                          fontInterSemiBold))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: List.generate(
                                                150 ~/ 2,
                                                (index) => Expanded(
                                                      child: Container(
                                                        color: index % 2 == 0
                                                            ? Colors.transparent
                                                            : Colors.grey,
                                                        height: 1,
                                                      ),
                                                    )),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                    Text(
                                        (controller.leaveList[index].remarks ?? ""),
                                        style: TextStyle(
                                            color: text_color, fontSize: 15)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    ((controller.leaveList[index].leaveStatusType ??
                                                "0") ==
                                            LeaveStatusEnum.pending.outputVal)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                          .selectedLeaveData.value =
                                                      controller.leaveList[index];
                                                  Get.to(EditLeaveView())?.then(
                                                      (value) => controller
                                                          .getLeaveListAPI());
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      icon_edit_pen,
                                                      height: 17,
                                                      width: 17,
                                                      color: color_primary,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text("EDIT",
                                                        style: TextStyle(
                                                            color: color_primary,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                fontInterRegular)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 22,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.callDeleteLeaveAPI(
                                                      controller.leaveList[index]
                                                              .id ??
                                                          "");
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      icon_delete,
                                                      height: 20,
                                                      width: 20,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text("DELETE",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                fontInterRegular)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text("Data Not Available"),
                      ),


                if(controller.isLoading.value)Center(child: CircularProgressIndicator(),)
              ],
            )
          ),
      ),
    );
  }
}
