import 'dart:developer';

import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_details_view.dart';
import 'package:fitness_track/Screens/Customer/Workout/view/AddWorkoutTrainingScreen.dart';
import 'package:fitness_track/Screens/Customer/Workout/view/WorkoutAddEditPage.dart';
import 'package:fitness_track/Screens/Customer/Workout/view/warmup_list_view.dart';
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

class WorkoutListView extends StatefulWidget {
  const WorkoutListView({Key? key}) : super(key: key);

  @override
  State<WorkoutListView> createState() => _WorkoutListViewState();
}

class _WorkoutListViewState extends State<WorkoutListView> {
  /// Initialize the controller
  WorkoutController controller = Get.put(WorkoutController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
      controller.getAllWorkoutListAPI(context);
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
          leading: Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
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
                  "Workout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(WorkoutAddEditPage(isEdit: false));
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: fontInterMedium),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Obx(() => controller.workoutListApiCall.value
            ? (controller.workoutList ?? []).isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.workoutList.length,
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
                          controller.selectedWorkoutData.value =
                              controller.workoutList[index];
                          Get.to(WorkoutDetailsView());
                        },
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
                              buildTitleValue(
                                title: "Code",
                                value: controller.workoutList[index].code ?? "",
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              buildTitleValue(
                                title: "From",
                                value: getDateOnly((controller
                                            .workoutList[index].workoutDate ??
                                        DateTime(2023))
                                    .toString()),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              buildTitleValue(
                                title: "To",
                                value: getDateOnly(
                                    (controller.workoutList[index].dueDate ??
                                            DateTime(2023))
                                        .toString()),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              buildTitleValue(
                                title: "Duration",
                                value: controller
                                        .workoutList[index].durationInDays ??
                                    "0",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildCircleMenuItem(
                                    icon: Icons.local_fire_department,
                                    label: "Warm up",
                                    color: color_primary,
                                    onTap: () {
                                      controller.selectedWorkoutData.value =
                                          controller.workoutList[index];
                                      Get.to(WarmupListView());
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  _buildCircleMenuItem(
                                    icon: Icons.fitness_center,
                                    label: "Workout",
                                    color: color_primary,
                                    onTap: () {
                                      controller.selectedWorkoutData.value =
                                          controller.workoutList[index];
                                      Get.to(AddWorkoutTrainingScreen());
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  _buildCircleMenuItem(
                                    icon: Icons.edit,
                                    label: "Edit",
                                    color: color_primary,
                                    onTap: () {
                                      controller.selectedWorkoutData.value =
                                          controller.workoutList[index];
                                      Get.to(WorkoutAddEditPage(isEdit: true));
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  _buildCircleMenuItem(
                                    icon: Icons.delete_forever,
                                    label: "Delete",
                                    color: Colors.red,
                                    onTap: () {
                                      showConfirmationDialog(
                                        context: context,
                                        title: "Delete",
                                        message:
                                            "Are you sure you want to delete this workout?",
                                        onConfirmed: () {
                                          controller.callDeleteWorkoutAPI(
                                            context,
                                            controller.workoutList[index]
                                                    .workoutId ??
                                                "",
                                          );
                                        },
                                        onCancelled: () {},
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    return Expanded(
      child: InkWell(
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
      ),
    );
  }

  Widget buildTitleValue({
    required String title,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title :  ",
            style: TextStyle(
              color: text_color,
              fontSize: 14,
              fontFamily: fontInterRegular,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: text_color, // <-- Different color
              fontSize: 14,
              fontFamily: fontInterSemiBold, // <-- Different font
            ),
          ),
        ],
      ),
    );
  }
}
