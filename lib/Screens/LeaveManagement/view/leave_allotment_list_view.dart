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

class LeaveAllotmentListView extends StatefulWidget {
  const LeaveAllotmentListView({Key? key}) : super(key: key);

  @override
  State<LeaveAllotmentListView> createState() => _LeaveAllotmentListViewState();
}

class _LeaveAllotmentListViewState extends State<LeaveAllotmentListView> {
  /// Initialize the controller
  LeaveManagementController controller = Get.put(LeaveManagementController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
      controller.getLeaveAllotmentListAPI();
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
                  "Leave Allotments",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),
              
            ],
          ),
        ),
        body: Obx(() => !controller.isLoading.value?
        (controller.leaveAllotmentList??[]).isNotEmpty?ListView.builder(
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              itemCount: controller.leaveAllotmentList.length,
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
                  onTap: () {

                  },
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
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(
                                  "CATEGORY :",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterRegular)),

                              SizedBox(width: 8,),

                              Text(
                                  controller.leaveAllotmentList[index].leaveCategoryName??"",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterSemiBold)),
                            ],
                          ),

                          SizedBox(height: 12,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(
                                  "TOTAL LEAVE :",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterRegular)),

                              SizedBox(width: 8,),

                              Text(
                                  controller.leaveAllotmentList[index].totalLeave??"0",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterSemiBold)),
                            ],
                          ),

                          SizedBox(height: 12,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(
                                  "START DATE :",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterRegular)),

                              SizedBox(width: 8,),

                              Text(
                                  getDateOnly((controller.leaveAllotmentList[index].startDate??DateTime(2024)).toString()),
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterSemiBold)),
                            ],
                          ),

                          SizedBox(height: 12,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(
                                  "END DATE :",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterRegular)),

                              SizedBox(width: 8,),

                              Text(
                                  getDateOnly((controller.leaveAllotmentList[index].endDate??DateTime(2024)).toString()),
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 13,
                                      fontFamily: fontInterSemiBold)),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ):Center(child: Text("No Record Found"),):Center(child: CircularProgressIndicator(),)),
      ),
    );
  }
}
