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
import '../controller/measurement_controller.dart';

class MeasurementListView extends StatefulWidget {
  const MeasurementListView({Key? key}) : super(key: key);

  @override
  State<MeasurementListView> createState() => _MeasurementListViewState();
}

class _MeasurementListViewState extends State<MeasurementListView> {
  /// Initialize the controller
  MeasurementController controller = Get.put(MeasurementController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
      controller.getAllMeasurementListAPI(context);
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
        // appBar: AppBar(
        //   backgroundColor: color_primary,
        //   titleSpacing: 0,
        //   automaticallyImplyLeading: true,
        //   leading: Builder(
        //     builder: (BuildContext context) {
        //       return InkWell(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: Container(
        //           margin: EdgeInsets.all(14),
        //           child: Image.asset(
        //             width: double.infinity,
        //             height: double.infinity,
        //             icon_staklist_logo,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        //   iconTheme: IconThemeData(
        //     color: Colors.white, //change your color here
        //   ),
        //   title: Row(
        //     children: [
        //       Expanded(
        //         child: Text(
        //           "Measurements",
        //           style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 16,
        //               fontFamily: fontInterMedium),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: Obx(() => controller.measurementListApiCall.value?
        (controller.measurementList??[]).isNotEmpty?ListView.builder(
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              itemCount: controller.measurementList.length,
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
                    controller.selectedMeasurementData.value =
                        controller.measurementList[index];
                    Get.to(MeasurementDetailsView());
                  },
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      // margin:
                      //     EdgeInsets.only(top: 6, bottom: 6, left: 0, right: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(
                            width: 0.5,
                            color: devider_color,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              getDateOnly(
                                  (controller.measurementList.value[index].date ??
                                          DateTime(2023))
                                      .toString()),
                              style: TextStyle(
                                  color:text_color,
                                  fontSize: 14,
                                  fontFamily: fontInterSemiBold)),
                          // SizedBox(
                          //   height: 4,
                          // ),
                          // Text(
                          //     "Measurement By " +
                          //         (controller
                          //                 .measurementList[index].trainerName ??
                          //             "Abdul Hameed"),
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 14,
                          //         fontFamily: fontInterSemiBold))
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
