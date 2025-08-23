import 'dart:developer';

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
import '../controller/salary_controller.dart';

class SalaryDetailsView extends StatefulWidget {
  const SalaryDetailsView({Key? key}) : super(key: key);

  @override
  State<SalaryDetailsView> createState() => _SalaryDetailsViewState();
}

class _SalaryDetailsViewState extends State<SalaryDetailsView> {
  /// Initialize the controller
  SalaryController controller = Get.find<SalaryController>();

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: text_color, // navigation bar color
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
                  "Salary Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),
            ],
          ),
        ),
        body: Obx(() => SingleChildScrollView(
          child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     color: notification_item_color,
                //     border: Border.all(
                //       width: 0.5,
                //       color: notification_item_color,
                //     )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                            getDateOnly(
                                    (controller.selectedSalary.value.startDate ??
                                            DateTime(2023))
                                        .toString()) +
                                " - ",
                            style: TextStyle(
                                color: text_color,
                                fontSize: 15,
                                fontFamily: fontInterSemiBold)),
                        Text(
                            getDateOnly(
                                (controller.selectedSalary.value.endDate ??
                                        DateTime(2023))
                                    .toString()),
                            style: TextStyle(
                                color: text_color,
                                fontSize: 15,
                                fontFamily: fontInterSemiBold)),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
          
                    // String? basicSalary;
                    // String? sundayAmt;
                    // String? totalSundays;
                    // String? petrol;
                    // String? overTimeAmt;
                    // String? totalOverTime;
                    // String? mgrMonthInc;
                    // String? penaltyAmt;
                    // String? totalPenalty;
                    // String? incomeInc;
                    // String? absentAmt;
                    // String? totalAbsent;
                    // String? lateMinAmt;
                    // String? totalLateMin;
                    // String? ppf;
                    // String? pTax;
                    // String? grossTotal;
                    // String? incGiven;
                    // String? advance;
                    // String? netTotal;
                    // String? targetComplete;
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Basic Salary",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.basicSalary ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),
          
                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Sunday Amount",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.sundayAmt ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Total Sundays",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.totalSundays ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Petrol",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.petrol ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Over Time Amount",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.overTimeAmt ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Total Overtime",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.totalOverTime ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Month Incentive",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.mgrMonthInc ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Penalty Amount",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.penaltyAmt ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Total Penalty Amount",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.totalPenalty ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Income Increment",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.totalPenalty ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Absent Amount",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.absentAmt ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Total Absent",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.totalAbsent ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Late Minute Amount",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.lateMinAmt ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Total Late Minute",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.totalLateMin ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("PPF",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.ppf ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Professional Tax",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.pTax ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Gross Total",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.grossTotal ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Incentive Given",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.incGiven ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Advance",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.advance ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Net Total",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.netTotal ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 4,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Target Completed",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedSalary.value.targetComplete ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        )),
      ),
    );
  }
}
