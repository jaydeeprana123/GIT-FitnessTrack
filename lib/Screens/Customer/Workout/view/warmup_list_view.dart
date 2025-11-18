import 'dart:developer';

import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_details_view.dart';
import 'package:fitness_track/Screens/Customer/Workout/view/WorkoutAddEditPage.dart';
import 'package:fitness_track/Screens/Customer/Workout/view/workout_details_view.dart';
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
import '../controller/workout_controller.dart';
import 'WarmupAddEditPage.dart';

class WarmupListView extends StatefulWidget {
  const WarmupListView({Key? key}) : super(key: key);

  @override
  State<WarmupListView> createState() => _WarmupListViewState();
}

class _WarmupListViewState extends State<WarmupListView> {
  /// Initialize the controller
  WorkoutController controller = Get.find<WorkoutController>();

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
      controller.getAllWarmupListAPI(context);
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
          titleSpacing: 0,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            "Warm up",
            style: TextStyle(
                fontFamily: fontInterMedium,
                fontSize: 16,
                color: Colors.white
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.to(WarmupAddEditPage(isEdit: false))?.then((value) {
                  controller.getAllWarmupListAPI(context);
                });
              },
              child: Row(
                children: [
                  Icon(Icons.add_circle, color: Colors.white,),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: fontInterMedium),
                  ),

                  SizedBox(width: 12,)
                ],
              ),
            )
          ],
        ),

        body: Obx(() => !controller.isLoading.value
            ? (controller.warmupList ?? []).isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.warmupList.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: color_primary,
                      //     border: Border.all(
                      //       width: 0.5,
                      //       color: Colors.white,
                      //     )),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(left: 0, right: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                              color: color_primary,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleValueText("Workout Name",
                                controller.warmupList[index].workoutName ?? ""),
                            const SizedBox(height: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTitleValueText("Set",
                                    controller.warmupList[index].sets ?? "0"),
                                const SizedBox(height: 4),
                                _buildTitleValueText(
                                    "Repeat No",
                                    controller.warmupList[index].repeatNo ??
                                        "0"),
                                const SizedBox(height: 4),
                                _buildTitleValueText(
                                    "Repeat Time",
                                    controller.warmupList[index].repeatTime ??
                                        "0"),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.selectedWarmupData.value =
                                        controller.warmupList[index];
                                    Get.to(WarmupAddEditPage(isEdit: true))
                                        ?.then((value) {
                                      controller.getAllWarmupListAPI(context);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.edit,
                                          color: color_primary),
                                      const SizedBox(width: 3),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: color_primary,
                                          fontSize: 11,
                                          fontFamily: fontInterSemiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                InkWell(
                                  onTap: () {
                                    showConfirmationDialog(
                                      context: context,
                                      title: "Delete",
                                      message:
                                          "Are you sure you want to delete this warmup?",
                                      onConfirmed: () {
                                        controller.callDeleteWarmupAPI(
                                          context,
                                          controller.warmupList[index].id ?? "",
                                        );
                                      },
                                      onCancelled: () {},
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.delete_forever,
                                          color: Colors.red),
                                      const SizedBox(width: 2),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 11,
                                          fontFamily: fontInterSemiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text("No Record Found"),
                  )
            : Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }

  Widget _buildCircleMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.15), // light background tint
              border: Border.all(color: color, width: 0.5),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: fontInterSemiBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleValueText(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title: ",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
              fontFamily: fontInterRegular,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: text_color,
              fontSize: 14,
              fontFamily: fontInterSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
