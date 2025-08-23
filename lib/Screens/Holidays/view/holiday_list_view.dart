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
import '../controller/holiday_controller.dart';



class HolidayListView extends StatefulWidget {
  const HolidayListView({Key? key}) : super(key: key);

  @override
  State<HolidayListView> createState() => _HolidayListViewState();
}

class _HolidayListViewState extends State<HolidayListView> {
  /// Initialize the controller
  HolidayController controller = Get.put(HolidayController());
  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");


    WidgetsBinding.instance.addPostFrameCallback((_) async{

      await controller.getUserInfo();
      controller.getHolidayListAPI();

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
        appBar:  AppBar(
          backgroundColor: color_primary,

          titleSpacing: 0,
          automaticallyImplyLeading: true,
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return  InkWell(
          //       onTap: (){
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
            color: Colors.white //change your color here
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "Holidays",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),


            ],
          ),
        ),
        body: Obx(() =>!controller.isLoading.value?Padding(
          padding: const EdgeInsets.only(top:12.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            primary: false,
            shrinkWrap: true,
            itemCount: controller.holidayList.length,
            itemBuilder: (context, index) => Container(

              margin: EdgeInsets.only( left: 12, right: 12),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: color_primary,
              //     border: Border.all(
              //       width: 0.5,
              //       color: text_color,
              //     )),
              child:  Container(
                width: double.infinity,
                // padding: EdgeInsets.all(12),
                // margin:
                // EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     color: notification_item_color,
                //     border: Border.all(
                //       width: 0.5,
                //       color: notification_item_color,
                //     )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                              getDateOnly((controller
                                  .holidayList
                                  [index]
                                  .date ?? DateTime(2023)).toString()) + "  -  ",
                              style: TextStyle(color: text_color,
                                  fontSize: 14,  fontFamily: fontInterRegular)),


                          Text(
                              controller
                                  .holidayList
                              [index]
                                  .name??"",
                              style: TextStyle(color: text_color,
                                  fontSize: 14,  fontFamily: fontInterSemiBold)),

                        ],
                      ),
                    ),

                    // SizedBox(height: 8,),

                    Divider(color: light_grey,)
                  ],
                ),
              ),
            ),
          ),
        ):Center(child: CircularProgressIndicator(),)),
      ),
    );
  }
}
