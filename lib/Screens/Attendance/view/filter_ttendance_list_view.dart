import 'dart:developer';

import 'package:fitness_track/Enums/attendance_type_status_enum.dart';
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
import '../../BottomNavigation/controller/bottom_navigation_controller.dart';
import '../controller/attendance_controller.dart';



class FilterAttendanceListView extends StatefulWidget {

  String attendanceType;

   FilterAttendanceListView({Key? key, required this.attendanceType}) : super(key: key);

  @override
  State<FilterAttendanceListView> createState() => _FilterAttendanceListViewState();
}

class _FilterAttendanceListViewState extends State<FilterAttendanceListView> {
  /// Initialize the controller
  AttendanceController controller = Get.put(AttendanceController());
  BottomNavigationController bottomNavController =
  Get.find<BottomNavigationController>();
  String attendanceTypeFinal = AttendanceTypeEnum.all.outputVal;
  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");


    WidgetsBinding.instance.addPostFrameCallback((_) async{

      await controller.getUserInfo(false);
      attendanceTypeFinal = bottomNavController.attendanceType.value;
      printData("widget.attendanceType", widget.attendanceType??"");
      setState(() {

      });

      printData("attendanceTypeFinal", attendanceTypeFinal);
      controller.getAttendanceListAPI(attendanceTypeFinal);

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
        appBar: AppBar(
          backgroundColor: color_primary,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "My Attendance",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: fontInterSemiBold),
                ),
              ),

              Visibility(
                visible: controller
                    .fromDateEditingController.value.text.isNotEmpty ||
                    controller
                        .toDateEditingController.value.text.isNotEmpty,
                child: InkWell(
                  onTap: () async {
                    controller.fromDateEditingController.value.clear();
                    controller.toDateEditingController.value.clear();

                    controller.getAttendanceListAPI(attendanceTypeFinal);

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
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        body: Obx(() =>Column(
          children: [



            SizedBox(height: 8,),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(children: [

                Expanded(
                  child: InkWell(
                    onTap: (){
                      attendanceTypeFinal = AttendanceTypeEnum.all.outputVal;
                      setState(() {

                      });

                      controller.getAttendanceListAPI(attendanceTypeFinal);


                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: attendanceTypeFinal == AttendanceTypeEnum.all.outputVal?color_primary:Colors.white,
                          border: Border.all(
                            width: 1,
                            color: color_primary,
                          )),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("All",
                            style: TextStyle(color: attendanceTypeFinal == AttendanceTypeEnum.all.outputVal?Colors.white:color_primary,
                                fontSize: 12,  fontFamily: fontInterSemiBold)),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12,),

                Expanded(
                  child: InkWell(
                    onTap: (){
                      attendanceTypeFinal = AttendanceTypeEnum.lateMark.outputVal;
                      setState(() {

                      });
                      controller.getAttendanceListAPI(attendanceTypeFinal);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: attendanceTypeFinal == AttendanceTypeEnum.lateMark.outputVal?color_primary:Colors.white,
                          border: Border.all(
                            width: 1,
                            color: color_primary,
                          )),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Late",
                            style: TextStyle(color: attendanceTypeFinal == AttendanceTypeEnum.lateMark.outputVal?Colors.white:color_primary,
                                fontSize: 12,  fontFamily: fontInterSemiBold)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12,),

                Expanded(
                  child: InkWell(
                    onTap: (){
                      attendanceTypeFinal = AttendanceTypeEnum.overTime.outputVal;
                      setState(() {

                      });
                      controller.getAttendanceListAPI(attendanceTypeFinal);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: attendanceTypeFinal == AttendanceTypeEnum.overTime.outputVal?color_primary:Colors.white,
                          border: Border.all(
                            width: 1,
                            color: color_primary,
                          )),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("OT",
                            style: TextStyle(color: attendanceTypeFinal == AttendanceTypeEnum.overTime.outputVal?Colors.white:color_primary,
                                fontSize: 12,  fontFamily: fontInterSemiBold)),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12,),

                Expanded(
                  child: InkWell(
                    onTap: (){
                      attendanceTypeFinal = AttendanceTypeEnum.absent.outputVal;
                      setState(() {

                      });
                      controller.getAttendanceListAPI(attendanceTypeFinal);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: attendanceTypeFinal == AttendanceTypeEnum.absent.outputVal?color_primary:Colors.white,
                          border: Border.all(
                            width: 1,
                            color: color_primary,
                          )),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Absent",
                            style: TextStyle(color: attendanceTypeFinal == AttendanceTypeEnum.absent.outputVal?Colors.white:color_primary,
                                fontSize: 12,  fontFamily: fontInterSemiBold)),
                      ),
                    ),
                  ),
                )

              ],),
            ),

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
                              getDateFormtYYYYMMDDOnly((dateTime ?? DateTime(2023))
                                  .toString());
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
                        child: Text(controller
                            .fromDateEditingController.value.text.isNotEmpty
                            ? controller
                            .fromDateEditingController.value.text
                            : "From"
                            ,
                            style: TextStyle(color: text_color,
                                fontSize: 14,  fontFamily: fontInterSemiBold)),
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
                          controller
                              .toDateEditingController.value.text =
                              getDateFormtYYYYMMDDOnly((dateTime ?? DateTime(2023))
                                  .toString());
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
                        child: Text(controller
                            .toDateEditingController.value.text.isNotEmpty
                            ? controller
                            .toDateEditingController.value.text
                            : "To",
                            style: TextStyle(color: text_color,
                                fontSize: 14,  fontFamily: fontInterSemiBold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.getAttendanceListAPI(attendanceTypeFinal);
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
              child: !controller.isLoading.value?Container(
                padding: EdgeInsets.all(12),
                child: controller.attendanceList.isNotEmpty?ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.attendanceList.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(12),
              
                        margin: EdgeInsets.only( left: 4, right: 4),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12),
                        //     color: color_primary,
                        //     border: Border.all(
                        //       width: 0.5,
                        //       color: text_color,
                        //     )),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            (controller.loginResponseModel.value.data?[0].regularShiftApply??"0") != "1"? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      icon_branch, height: 20, width: 20,color: color_primary,),
                                    SizedBox(width: 6,),

                                    Text(
                                        ((controller
                                            .attendanceList
                                        [index]
                                            .branchName ?? "")) ,
                                        style: TextStyle(color: color_primary,
                                            fontSize: 13,  fontFamily: fontInterSemiBold)),

                                  ],
                                ),

                                SizedBox(height: 12,),

                              ],
                            ):SizedBox(),



                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      SvgPicture.asset(
                                        icon_calender_date_event, height: 20, width: 20,color: text_color,),
                                      SizedBox(width: 6,),

                                      Text(
                                          getDateOnly((controller
                                              .attendanceList
                                              [index]
                                              .date ?? DateTime(2023)).toString()) ,
                                          style: TextStyle(color: text_color,
                                              fontSize: 13,  fontFamily: fontInterSemiBold)),

                                    ],
                                  ),
                                ),

                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.red,
                                      )),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [

                                        Text((controller
                                            .attendanceList
                                        [index]
                                            .shiftName??""),
                                            style: TextStyle(color: Colors.red,
                                                fontSize: 12,  fontFamily: fontInterSemiBold)),
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),


              
                            SizedBox(height: 10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
              
                                Text(
                                    "SHIFT IN : " ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterRegular)),
              
                                SizedBox(width: 4,),
              
                                Text(
                                    (controller
                                        .attendanceList
                                    [index]
                                        .shiftIn??"").isNotEmpty?Helper().convert24To12Hour(controller
                                        .attendanceList
                                    [index]
                                        .shiftIn??""):"" ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterSemiBold)),
              
                              ],
                            ),
              
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
              
                                Text(
                                    "SHIFT OUT : " ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterRegular)),
              
                                SizedBox(width: 4,),

                                Text(
                                    (controller
                                        .attendanceList
                                    [index]
                                        .shiftOut??"").isNotEmpty?Helper().convert24To12Hour(controller
                                        .attendanceList
                                    [index]
                                        .shiftOut??""):"" ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterSemiBold)),
              
                              ],
                            ),
              
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
              
                                Text(
                                    "OVER TIME : " ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterRegular)),
              
                                SizedBox(width: 4,),
              
                                Text(
                                    controller
                                        .attendanceList
                                    [index]
                                        .overTime??"" ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterSemiBold)),
              
                              ],
                            ),
              
              
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
              
                                Text(
                                    "LATE PUNCH : " ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterRegular)),
              
                                SizedBox(width: 4,),
              
                                Text(
                                    controller
                                        .attendanceList
                                    [index]
                                        .latePunch??"" ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterSemiBold)),
              
                              ],
                            ),

                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Text(
                                    "ABSENT : " ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterRegular)),

                                SizedBox(width: 4,),

                                Text(
                                    (controller
                                        .attendanceList
                                    [index]
                                        .absent??false)?"Yes":"No" ,
                                    style: TextStyle(color: text_color,
                                        fontSize: 13,  fontFamily: fontInterSemiBold)),

                              ],
                            ),
              
              
                            // SizedBox(height: 8,),
                            //
                            // Divider()
                          ],
                        ),
                      ),
                    ),
                  ),
                ):Center(child: Text("Data Not Available"),),
              ):Center(child: CircularProgressIndicator(),),
            ),
          ],
        )),
      ),
    );
  }
}
