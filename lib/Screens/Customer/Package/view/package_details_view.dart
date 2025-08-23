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
import '../controller/package_controller.dart';


class PackageDetailView extends StatefulWidget {
  const PackageDetailView({Key? key}) : super(key: key);

  @override
  State<PackageDetailView> createState() => _PackageDetailViewState();
}

class _PackageDetailViewState extends State<PackageDetailView> {
  /// Initialize the controller
  PackageController controller = Get.find<PackageController>();
  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");


    WidgetsBinding.instance.addPostFrameCallback((_) async{

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
                  "PACKAGE DETAILS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),


            ],
          ),
        ),
        body: Obx(() =>Container(
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

              Text(
                  controller.selectedPackage.value.packageName??"",
                  style: TextStyle(color: button_Color,
                      fontSize: 14,  fontFamily: fontInterSemiBold)),

              SizedBox(
                height: 4,
              ),

              Text(
                  controller.selectedPackage.value.packageCategoryName??"",
                  style: TextStyle(color: button_Color,
                      fontSize: 12,  fontFamily: fontInterRegular)),

              SizedBox(
                height: 4,
              ),

              Row(
                children: [
                  Text("Duration",
                      style: TextStyle(color: Colors.white,
                          fontSize: 13,  fontFamily: fontInterRegular)),

                  SizedBox(width: 4,),

                  Expanded(
                    child: Text(
                        controller
                            .selectedPackage
                            .value
                            .duration ??
                            "0",
                        style: TextStyle(color: Colors.white,
                            fontSize: 13,  fontFamily: fontInterSemiBold)),
                  ),


                ],
              ),


              SizedBox(
                height: 4,
              ),

              Text(
                  controller.selectedPackage.value.remarks??"",
                  style: TextStyle(color: button_Color,
                      fontSize: 12,  fontFamily: fontInterRegular)),


              SizedBox(
                height: 4,
              ),

              Text(
                  controller.selectedPackage.value.packageDescription??"",
                  style: TextStyle(color: button_Color,
                      fontSize: 12,  fontFamily: fontInterRegular)),


            ],
          ),
        )),
      ),
    );
  }
}
