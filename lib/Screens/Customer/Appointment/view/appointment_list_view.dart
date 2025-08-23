import 'dart:developer';

import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_details_view.dart';
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
import '../controller/appointment_controller.dart';
import 'add_appointment_view.dart';
import 'edit_appointment_view.dart';

class AppointmentListView extends StatefulWidget {
  const AppointmentListView({Key? key}) : super(key: key);

  @override
  State<AppointmentListView> createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  /// Initialize the controller
  AppointmentController controller = Get.put(AppointmentController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
      controller.getAllAppointmentListAPI(context);
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
                  "Appointments",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),

              InkWell(
                onTap: (){
                  Get.to(AddAppointmentView())?.then((value) => controller.getAllAppointmentListAPI(context));
                },
                child: Row(
                  children: [

                    SvgPicture.asset(
                      icon_add_plus_square_new, height: 22, width: 22,color: Colors.white,),
                    SizedBox(width: 4,),

                    Text(
                        "Book",
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
        body: Obx(() => ListView.builder(
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              itemCount: controller.appointmentList.length,
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
                    controller.selectedAppointmentData.value =
                        controller.appointmentList[index];
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
                            children: [

                              SvgPicture.asset(
                                icon_calender_date_event, height: 18, width: 18,),
                              SizedBox(width: 4,),

                              Text(
                                  ((
                                      (controller.appointmentList.value[index].date ??
                                          "")
                                          .toString())) + "   "  + ((
                                      (controller.appointmentList.value[index].time ??
                                          "")
                                          .toString())),
                                  style: TextStyle(
                                      color: hint_txt_909196,
                                      fontSize: 11,
                                      fontFamily: fontInterSemiBold)),
                            ],
                          ),

                          SizedBox(height: 6,),

                          Text(

                                  (controller
                                          .appointmentList[index].remarks ??
                                      ""),
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 15)),





                          SizedBox(height: 12,),
                          Row( mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              InkWell(
                                onTap: (){
                                  controller.selectedAppointmentData.value = controller
                                      .appointmentList[index];
                                  Get.to(EditAppointmentView())?.then((value) => controller.getAllAppointmentListAPI(context));
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                     icon_edit_pen, height: 17, width: 17,color: color_primary,),
                                    SizedBox(width: 3,),
                                    Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: text_color,
                                            fontSize: 12,
                                            fontFamily: fontInterSemiBold)),
                                  ],
                                ),
                              ),

                              SizedBox(width: 16,),

                              InkWell(
                                onTap: (){
                                  controller.callDeleteAppointmentAPI(context, controller
                                      .appointmentList[index].id ??
                                      "");
                                },
                                child: Row(

                                  children: [
                                    SvgPicture.asset(
                                      icon_delete, height: 17, width: 17,),
                                    SizedBox(width: 3,),
                                    Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: text_color,
                                            fontSize: 12,
                                            fontFamily: fontInterSemiBold)),
                                  ],
                                ),
                              )

                            ],
                          )


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
