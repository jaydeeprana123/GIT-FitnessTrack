import 'dart:developer';

import 'package:fitness_track/Screens/Attendance/view/branch_wise_attendance_list_view.dart';
import 'package:fitness_track/Screens/Dashboard/model/dashboard_counter_model.dart';
import 'package:fitness_track/Screens/DayInDayOut/view/day_in_out_view.dart';
import 'package:fitness_track/Screens/DayInDayOut/view/shift_list_view.dart';
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
import '../../../Utils/preference_utils.dart';
import '../../../Utils/share_predata.dart';
import '../../DayInDayOut/controller/shift_controller.dart';


class BranchListViewForAttendance extends StatefulWidget {
  BranchListViewForAttendance({Key? key}) : super(key: key);

  @override
  State<BranchListViewForAttendance> createState() => _BranchListViewForAttendanceState();
}

class _BranchListViewForAttendanceState extends State<BranchListViewForAttendance> {
  /// Initialize the controller
  ShiftController controller = Get.put(ShiftController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
      controller.getBranchListAPI();
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
          //     return InkWell(
          //       onTap: () {
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
                  "Branchs",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),
            ],
          ),
        ),
        body: Obx(() => !controller.isLoading.value
            ? (controller.branchList ?? []).isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.branchList.length,
                    padding: EdgeInsets.only(top: 12),
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: color_primary,
                      //     border: Border.all(
                      //       width: 0.5,
                      //       color: Colors.white,
                      //     )),
                      child: InkWell(
                        onTap: (){

                          Get.to(BranchWiseAttendanceListView(branchName: controller.branchList[index].name??"",branchId: controller.branchList[index].id??"",));

                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 16, right: 16, top: 12),

                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(12),
                          //     border: Border.all(
                          //       width: 0.5,
                          //       color: Colors.white,
                          //     )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(controller.branchList[index].name ?? "",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 14,
                                      fontFamily: fontInterSemiBold)),

                              SizedBox(height: 12,),

                              Divider(color: light_grey,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                    ("No Branch Available"),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: fontInterSemiBold),
                  ))
            : Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }
}
