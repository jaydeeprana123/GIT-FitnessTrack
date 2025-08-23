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
import '../controller/measurement_controller.dart';

class MeasurementDetailsView extends StatefulWidget {
  const MeasurementDetailsView({Key? key}) : super(key: key);

  @override
  State<MeasurementDetailsView> createState() => _MeasurementDetailsViewState();
}

class _MeasurementDetailsViewState extends State<MeasurementDetailsView> {
  /// Initialize the controller
  MeasurementController controller = Get.find<MeasurementController>();

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
                  "Measurement Details",
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
                    Text(
                        getDateOnly(
                                (controller.selectedMeasurementData.value.date ??
                                        DateTime(2023))
                                    .toString()) ,
                        style: TextStyle(
                            color: text_color,
                            fontSize: 15,
                            fontFamily: fontInterSemiBold)),
                    SizedBox(
                      height: 16,
                    ),

      //   dynamic trainerName;
      // String? frontView;
      // String? backView;
      // String? leftView;
      // String? rightView;
      // DateTime? date;
      // String? weight;
      // String? height;
      // String? neck;
      // String? shoulder;
      // String? normalChest;
      // String? expandedChest;
      // String? upperArm;
      // String? foreArm;
      // String? upperAbdomen;
      // String? waist;
      // String? lowerAbdomen;
      // String? hips;
      // String? thigh;
      // String? calf;
      // String? whr;
      // String? bmi;
      // String? sign;
      // String? bicep;
      // String? tricep;
      // String? subscapula;
      // String? suprailliac;
      // String? total;
      // String? percentage;
      // String? healthRisk;
      // String? low;
      // String? medium;
      // String? high;
      // String? underweight;
      // String? normal;
      // String? overweight;
      // String? obeseGrade1;
      // String? obeseGrade2;
      // String? obeseGrade3;
      // String? bmr;
          
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text("Measurement By",
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterRegular)),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //           ((controller.selectedMeasurementData.value.trainerName ??
                    //               "Abdul Hameed")),
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterSemiBold)),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    //
                    // Divider(color: devider_color,),
                    //
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text("Front View",
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterRegular)),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //           ((controller.selectedMeasurementData.value.frontView ??
                    //               "0")),
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterSemiBold)),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    //
                    // Divider(color: devider_color,),
                    //
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text("Back View",
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterRegular)),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //           ((controller.selectedMeasurementData.value.backView ??
                    //               "0")),
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterSemiBold)),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    //
                    // Divider(color: devider_color,),
                    //
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    //
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text("Left View",
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterRegular)),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //           ((controller.selectedMeasurementData.value.leftView ??
                    //               "0")),
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterSemiBold)),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    //
                    // Divider(color: devider_color,),
                    //
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text("Right View",
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterRegular)),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //           ((controller.selectedMeasurementData.value.rightView ??
                    //               "0")),
                    //           style: TextStyle(
                    //               color: text_color,
                    //               fontSize: 13,
                    //               fontFamily: fontInterSemiBold)),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
                    //
                    // Divider(color: devider_color,),
                    //
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Weight",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.weight ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Height",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.height ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Neck",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.neck ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Shoulder",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.shoulder ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Normal Chest",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.normalChest ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Expanded Chest",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.expandedChest ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Upper Arm",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.upperArm ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Fore Arm",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.foreArm ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Upper Abdomen",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.upperAbdomen ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Waist",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.waist ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Lower Abdomen",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.lowerAbdomen ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Hips",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.hips ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Thigh",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.thigh ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Calf",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.calf ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("WHR",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.whr ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("BMI",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.bmi ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Sign",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.sign ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Biceps",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.bicep ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Triceps",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.tricep ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Subscapula",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.subscapula ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Suprailliac",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.suprailliac ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Total",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.total ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Percentage",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.percentage ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Health Risk",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.healthRisk ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Low",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.low ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Medium",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.medium ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("High",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.high ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Underweight",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.underweight ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Normal",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.normal ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Overweight",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.overweight ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Obese Grade 1",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.obeseGrade1 ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Obese Grade 2",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.obeseGrade2 ??
                                  "0")),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Divider(color: devider_color,),


                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Obese Grade 3",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          child: Text(
                              ((controller.selectedMeasurementData.value.obeseGrade3 ??
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
