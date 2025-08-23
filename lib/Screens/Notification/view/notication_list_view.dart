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
import '../controller/notification_controller.dart';


class NoticationListView extends StatefulWidget {
  const NoticationListView({Key? key}) : super(key: key);

  @override
  State<NoticationListView> createState() => _NoticationListViewState();
}

class _NoticationListViewState extends State<NoticationListView> {
  /// Initialize the controller
  NotificationController controller = Get.put(NotificationController());
  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");


    WidgetsBinding.instance.addPostFrameCallback((_) {});
  controller.getAllNotificationListAPI(context);
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
        backgroundColor: color_primary,
        resizeToAvoidBottomInset: true,
        appBar:  AppBar(
          backgroundColor: color_primary,

          titleSpacing: 0,
          automaticallyImplyLeading: true,
          leading: Builder(
            builder: (BuildContext context) {
              return  InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(14),
                  child: Image.asset(
                    width: double.infinity,
                    height: double.infinity,
                    icon_staklist_logo,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "NOTIFICATIONS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),


            ],
          ),
        ),
        body: Obx(() =>ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: controller.notificationList.length,
          itemBuilder: (context, index) => Container(

            margin: EdgeInsets.only( left: 12, right: 12),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: color_primary,
            //     border: Border.all(
            //       width: 0.5,
            //       color: Colors.white,
            //     )),
            child:  Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin:
              EdgeInsets.only(top: 6, bottom: 6, left: 0, right: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: notification_item_color,
                  border: Border.all(
                    width: 0.5,
                    color: notification_item_color,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "By Admin",
                            style: TextStyle(color: button_Color,
                                fontSize: 12,  fontFamily: fontInterSemiBold)),
                      ),


                      Text(
                          getDateOnly((controller
                              .notificationList
                              .value[index]
                              .date ?? DateTime(2023)).toString()),
                          style: TextStyle(color: Colors.white,
                              fontSize: 12,  fontFamily: fontInterSemiBold)),

                      Text(
                          " | ${controller
                              .notificationList
                              .value[index]
                              .time ?? ""}",
                          style: TextStyle(color: Colors.white,
                              fontSize: 12,  fontFamily: fontInterSemiBold)),

                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            controller
                                .notificationList
                                .value[index]
                                .message ??
                                "",
                            style: TextStyle(color: Colors.white,
                                fontSize: 14,  fontFamily: fontInterSemiBold)),
                      ),


                      // Container(
                      //   padding: EdgeInsets.all(4)
                      //   ,decoration: new BoxDecoration(
                      //     color: notification_item_color,
                      //     shape: BoxShape.circle,
                      //     boxShadow: [new BoxShadow(
                      //       color: Colors.black,
                      //       blurRadius: 1.0,
                      //     ),]
                      // ),
                      //   child: SvgPicture.asset(
                      //     icon_delete, height: 16, width: 16,color: Colors.white,),
                      // )


                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
