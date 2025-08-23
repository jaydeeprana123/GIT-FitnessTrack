import 'dart:developer';

import 'package:fitness_track/Screens/DayInDayOut/view/day_in_out_view.dart';
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
import '../controller/shift_controller.dart';

class ShiftListView extends StatefulWidget {
  final bool isFromBottomNavigation;
  final String branchId;
  final String branchName;
  ShiftListView(
      {Key? key, required this.isFromBottomNavigation, required this.branchId, required this.branchName})
      : super(key: key);

  @override
  State<ShiftListView> createState() => _ShiftListViewState();
}

class _ShiftListViewState extends State<ShiftListView> {
  /// Initialize the controller
  ShiftController controller = Get.put(ShiftController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();

      if (widget.isFromBottomNavigation) {
        controller.branchIdMain =
            controller.loginResponseModel.value.data?[0].branchId ?? "";
      } else {
        controller.branchIdMain = widget.branchId ?? "";
      }
      controller.getShiftListAPI(true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: color_primary, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: !widget.isFromBottomNavigation
            ? AppBar(
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
                        "Shifts (${(widget.branchName??"")})",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: fontInterMedium),
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: Obx(() => Stack(
              children: [
                (controller.shiftList).isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: controller.shiftList.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                          child: InkWell(
                            onTap: () {
                              Get.to(DayInOutView(
                                shiftId: controller.shiftList[index].shiftId ?? "",
                                branchId: controller.branchIdMain,
                                status: (controller.shiftList[index].status ?? 0)
                                    .toString(),
                              ))?.then((value) {

                                Future.delayed(Duration(milliseconds: 100), () {
                                  controller.getShiftListAPI(false);
                                });


                              } );
                            },
                            child: Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: (controller.shiftList[index].status ?? 0) == 2
                                  ? Colors.green
                                  : Colors.white,
                              // shadowColor: Colors.white,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                //  color: (controller.shiftList[index].status ?? 0) == 2?Colors.green:Colors.white,

                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(12),
                                //     border: Border.all(
                                //       width: 0.5,
                                //       color: Colors.white,
                                //     )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        controller.shiftList[index].shiftName ?? "",
                                        style: TextStyle(
                                            color: (controller.shiftList[index]
                                                            .status ??
                                                        0) ==
                                                    2
                                                ? Colors.white
                                                : title_black_15181e,
                                            fontSize: 15,
                                            fontFamily: fontInterMedium)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            controller.shiftList[index].startTime ??
                                                "",
                                            style: TextStyle(
                                                color: (controller.shiftList[index]
                                                                .status ??
                                                            0) ==
                                                        2
                                                    ? Colors.white
                                                    : text_color,
                                                fontSize: 12,
                                                fontFamily: fontInterRegular)),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text("-",
                                            style: TextStyle(
                                                color: (controller.shiftList[index]
                                                                .status ??
                                                            0) ==
                                                        2
                                                    ? Colors.white
                                                    : title_black_15181e,
                                                fontSize: 12,
                                                fontFamily: fontInterRegular)),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                            controller.shiftList[index].endTime ??
                                                "",
                                            style: TextStyle(
                                                color: (controller.shiftList[index]
                                                                .status ??
                                                            0) ==
                                                        2
                                                    ? Colors.white
                                                    : text_color,
                                                fontSize: 12,
                                                fontFamily: fontInterRegular)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : (!controller.isLoading.value)?Center(
                        child: Text(
                        ("No Shift Available"),
                        // style: TextStyle(
                        //     fontSize: 15,
                        //     color: Colors.white,
                        //     fontFamily: fontInterSemiBold),
                      )):SizedBox(),


                if(controller.isLoading.value)Center(
                  child: CircularProgressIndicator(),
                )
              ],
            )
            ),
      ),
    );
  }


  @override
  void dispose() {
    controller.isLoading.value = false;
    super.dispose();
  }
}
