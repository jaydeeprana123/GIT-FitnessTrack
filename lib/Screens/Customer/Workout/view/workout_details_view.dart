import 'dart:developer';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_details_view.dart';
import 'package:flutter/rendering.dart';
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
import 'AddWorkoutTrainingScreen.dart';
import 'AutoPlayVideoWidget.dart';
import 'VideoPlayerPage.dart';
import 'VideoThumbnailWidget.dart';
import 'WorkoutVideoPlayer.dart';

class WorkoutDetailsView extends StatefulWidget {
  const WorkoutDetailsView({Key? key}) : super(key: key);

  @override
  State<WorkoutDetailsView> createState() => _WorkoutDetailsViewState();
}

class _WorkoutDetailsViewState extends State<WorkoutDetailsView> {
  /// Initialize the controller
  WorkoutController controller = Get.find<WorkoutController>();

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
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "Workout Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit_calendar_sharp),
                color: Colors.white,
                onPressed: () {
                  Get.to(AddWorkoutTrainingScreen(
                    workoutId:
                        controller.selectedWorkoutData.value.workoutId ?? "0",
                    isEdit: true,
                  ));
                },
              )
            ],
          ),
        ),
        body: Obx(() => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Code : ${controller.selectedWorkoutData.value.code ?? ""}",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 14,
                            fontFamily: fontInterSemiBold)),

                    SizedBox(
                      height: 4,
                    ),

                    Row(
                      children: [
                        Text(
                            "From : " +
                                (getDateOnly((controller.selectedWorkoutData
                                            .value.workoutDate ??
                                        DateTime(2023))
                                    .toString())) +
                                "  To : " +
                                (getDateOnly((controller.selectedWorkoutData
                                            .value.dueDate ??
                                        DateTime(2023))
                                    .toString())),
                            style: TextStyle(
                                color: text_color,
                                fontSize: 14,
                                fontFamily: fontInterRegular)),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                        "Duration : ${controller.selectedWorkoutData.value.durationInDays ?? "0"}",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 14,
                            fontFamily: fontInterRegular)),

                    SizedBox(
                      height: 20,
                    ),

                    // Divider(),
                    //
                    // SizedBox(
                    //   height: 8,
                    // ),

                    Text("WARM UP",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 16,
                            fontFamily: fontInterSemiBold)),
                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text("Training Schedule",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("SETS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("REP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              textAlign: TextAlign.center,
                              "WEIGHT",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterSemiBold)),
                        )
                      ],
                    ),

                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      itemCount:
                          (controller.selectedWorkoutData.value.warmupList ??
                                  [])
                              .length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(top: 8),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12),
                        //     color: color_primary,
                        //     border: Border.all(
                        //       width: 0.5,
                        //       color: Colors.white,
                        //     )),
                        child: InkWell(
                          onTap: () {
                            // controller.selectedWorkoutData.value =
                            // controller.workoutList[index];
                            // Get.to(WorkoutDetailsView());
                          },
                          child: Container(
                            width: double.infinity,
                            // padding: EdgeInsets.all(12),
                            // margin:
                            // EdgeInsets.only( left: 0, right: 0),
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
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          controller
                                                  .selectedWorkoutData
                                                  .value
                                                  .warmupList?[index]
                                                  .masterWorkoutName ??
                                              "",
                                          style: TextStyle(
                                              color: text_color,
                                              fontSize: 13,
                                              fontFamily: fontInterRegular)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          controller.selectedWorkoutData.value
                                                  .warmupList?[index].sets ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: text_color,
                                              fontSize: 13,
                                              fontFamily: fontInterRegular)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          controller
                                                  .selectedWorkoutData
                                                  .value
                                                  .warmupList?[index]
                                                  .repeatNo ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: text_color,
                                              fontSize: 13,
                                              fontFamily: fontInterRegular)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          controller
                                                  .selectedWorkoutData
                                                  .value
                                                  .warmupList?[index]
                                                  .repeatTime ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: text_color,
                                              fontSize: 13,
                                              fontFamily: fontInterRegular)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    Container(
                      color: grey_f0f0f0,
                      height: 2,
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    Text("EXERCISE ROUTINE",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 16,
                            fontFamily: fontInterSemiBold)),

                    SizedBox(
                      height: 4,
                    ),

                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      cacheExtent: 500,
                      itemCount: (controller.selectedWorkoutData.value
                                  .workoutTrainingList ??
                              [])
                          .length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(top: 8),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12),
                        //     color: color_primary,
                        //     border: Border.all(
                        //       width: 0.5,
                        //       color: Colors.white,
                        //     )),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            // padding: EdgeInsets.all(12),
                            // margin:
                            // EdgeInsets.only( left: 0, right: 0),
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
                                    "Day " +
                                        (controller
                                                .selectedWorkoutData
                                                .value
                                                .workoutTrainingList?[index]
                                                .day ??
                                            ""),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: text_color,
                                        fontSize: 14,
                                        fontFamily: fontInterSemiBold)),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: (controller
                                              .selectedWorkoutData
                                              .value
                                              .workoutTrainingList?[index]
                                              .workoutTrainingCategory ??
                                          [])
                                      .length,
                                  itemBuilder: (context, j) => Container(
                                    margin: EdgeInsets.only(top: 8),
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     color: color_primary,
                                    //     border: Border.all(
                                    //       width: 0.5,
                                    //       color: Colors.white,
                                    //     )),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: double.infinity,
                                        // padding: EdgeInsets.all(12),
                                        // margin:
                                        // EdgeInsets.only( left: 0, right: 0),
                                        // decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(12),
                                        //     color: notification_item_color,
                                        //     border: Border.all(
                                        //       width: 0.5,
                                        //       color: notification_item_color,
                                        //     )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                                controller
                                                        .selectedWorkoutData
                                                        .value
                                                        .workoutTrainingList?[
                                                            index]
                                                        .workoutTrainingCategory?[
                                                            j]
                                                        .workoutTrainingCategoryName ??
                                                    "",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontFamily:
                                                        fontInterSemiBold)),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      "Training Schedule",
                                                      style: TextStyle(
                                                          color: text_color,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              fontInterSemiBold)),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text("SETS",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: text_color,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              fontInterSemiBold)),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text("REP",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: text_color,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              fontInterSemiBold)),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      "WEIGHT",
                                                      style: TextStyle(
                                                          color: text_color,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              fontInterSemiBold)),
                                                )
                                              ],
                                            ),
                                            ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount: (controller
                                                          .selectedWorkoutData
                                                          .value
                                                          .workoutTrainingList?[
                                                              index]
                                                          .workoutTrainingCategory?[
                                                              j]
                                                          .workoutTrainingSubCategory ??
                                                      [])
                                                  .length,
                                              itemBuilder: (context, z) =>
                                                  Container(
                                                margin: EdgeInsets.only(top: 8),
                                                // decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.circular(12),
                                                //     color: color_primary,
                                                //     border: Border.all(
                                                //       width: 0.5,
                                                //       color: Colors.white,
                                                //     )),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: double.infinity,
                                                    // padding: EdgeInsets.all(12),
                                                    // margin:
                                                    // EdgeInsets.only( left: 0, right: 0),
                                                    // decoration: BoxDecoration(
                                                    //     borderRadius: BorderRadius.circular(12),
                                                    //     color: notification_item_color,
                                                    //     border: Border.all(
                                                    //       width: 0.5,
                                                    //       color: notification_item_color,
                                                    //     )),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  controller
                                                                          .selectedWorkoutData
                                                                          .value
                                                                          .workoutTrainingList?[
                                                                              index]
                                                                          .workoutTrainingCategory?[
                                                                              j]
                                                                          .workoutTrainingSubCategory?[
                                                                              z]
                                                                          .workoutDetailName ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      color:
                                                                          text_color,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          fontInterRegular)),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  controller
                                                                          .selectedWorkoutData
                                                                          .value
                                                                          .workoutTrainingList?[
                                                                              index]
                                                                          .workoutTrainingCategory?[
                                                                              j]
                                                                          .workoutTrainingSubCategory?[
                                                                              z]
                                                                          .sets ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color:
                                                                          text_color,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          fontInterRegular)),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  controller
                                                                          .selectedWorkoutData
                                                                          .value
                                                                          .workoutTrainingList?[
                                                                              index]
                                                                          .workoutTrainingCategory?[
                                                                              j]
                                                                          .workoutTrainingSubCategory?[
                                                                              z]
                                                                          .repeatNo ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color:
                                                                          text_color,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          fontInterRegular)),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  controller
                                                                          .selectedWorkoutData
                                                                          .value
                                                                          .workoutTrainingList?[
                                                                              index]
                                                                          .workoutTrainingCategory?[
                                                                              j]
                                                                          .workoutTrainingSubCategory?[
                                                                              z]
                                                                          .repeatTime ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color:
                                                                          text_color,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          fontInterRegular)),
                                                            ),
                                                          ],
                                                        ),

                                                        if ((controller
                                                                    .selectedWorkoutData
                                                                    .value
                                                                    .workoutTrainingList?[
                                                                        index]
                                                                    .workoutTrainingCategory?[
                                                                        j]
                                                                    .workoutTrainingSubCategory?[
                                                                        z]
                                                                    .workoutDetailVideoList ??
                                                                [])
                                                            .isNotEmpty)
                                                          Container(
                                                            height: 160,
                                                            margin: REdgeInsets
                                                                .only(
                                                                    bottom: 12),
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount: (controller
                                                                          .selectedWorkoutData
                                                                          .value
                                                                          .workoutTrainingList?[
                                                                              index]
                                                                          .workoutTrainingCategory?[
                                                                              j]
                                                                          .workoutTrainingSubCategory?[
                                                                              z]
                                                                          .workoutDetailVideoList ??
                                                                      [])
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, g) {
                                                                final videoPath = controller
                                                                        .selectedWorkoutData
                                                                        .value
                                                                        .workoutTrainingList?[
                                                                            index]
                                                                        .workoutTrainingCategory?[
                                                                            j]
                                                                        .workoutTrainingSubCategory?[
                                                                            z]
                                                                        .workoutDetailVideoList?[
                                                                            g]
                                                                        .video ??
                                                                    "";

                                                                return FutureBuilder<
                                                                    Uint8List?>(
                                                                  future: _getThumbnail(
                                                                      videoPath),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return const SizedBox(
                                                                        width:
                                                                            160,
                                                                        child: Center(
                                                                            child:
                                                                                CircularProgressIndicator()),
                                                                      );
                                                                    }

                                                                    if (snapshot
                                                                            .hasError ||
                                                                        snapshot.data ==
                                                                            null) {
                                                                      return const SizedBox(
                                                                        width:
                                                                            160,
                                                                        child: Center(
                                                                            child:
                                                                                Icon(Icons.error, color: Colors.red)),
                                                                      );
                                                                    }

                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // Navigator.push(
                                                                        //   context,
                                                                        //   MaterialPageRoute(
                                                                        //     builder: (context) => VideoPlayerPage(videoPath: videoPath,exerciseName: controller
                                                                        //         .selectedWorkoutData.value.workoutTrainingList?[index]
                                                                        //         .workoutTrainingCategory?[j]
                                                                        //         .workoutTrainingSubCategory?[z].workoutDetailName??"",),
                                                                        //   ),
                                                                        // );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            200,
                                                                        margin: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                8),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              child: AutoPlayVideoWidget(videoUrl: videoPath),
                                                                            ),

                                                                            // ClipRRect(
                                                                            //   borderRadius: BorderRadius.circular(12),
                                                                            //   child: Image.memory(
                                                                            //     snapshot.data!,
                                                                            //     fit: BoxFit.cover,
                                                                            //     width: 160,
                                                                            //     height: 120, // bigger height
                                                                            //   ),
                                                                            // ),
                                                                            const SizedBox(height: 6),
                                                                            Text(
                                                                              "Video ${g + 1}",
                                                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),

                                                        // for(int g=0 ; g< (controller.selectedWorkoutData.value.workoutTrainingList?[index].workoutTrainingCategory?[j].workoutTrainingSubCategory?[z].workoutDetailVideoList??[]).length; g++)
                                                        //    Row(
                                                        //      children: [
                                                        //        WorkoutVideoPlayer(videoUrl: controller.selectedWorkoutData.value.workoutTrainingList?[index].workoutTrainingCategory?[j].workoutTrainingSubCategory?[z].workoutDetailVideoList?[g].video??"")
                                                        //      ],
                                                        //    )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: List.generate(
                                      150 ~/ 2,
                                      (index) => Expanded(
                                            child: Container(
                                              color: index % 2 == 0
                                                  ? Colors.transparent
                                                  : Colors.grey,
                                              height: 1,
                                            ),
                                          )),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<Uint8List?> _getThumbnail(String videoPath) async {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 400, // generate higher resolution thumbnail
      quality: 90, // keep quality high
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
