import 'package:fitness_track/Screens/Customer/Workout/view/AddWorkoutTrainingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../controller/workout_controller.dart';

class WorkoutTrainingListScreen extends StatefulWidget {
  const WorkoutTrainingListScreen({super.key});

  @override
  State<WorkoutTrainingListScreen> createState() =>
      _WorkoutTrainingListScreenState();
}

class _WorkoutTrainingListScreenState extends State<WorkoutTrainingListScreen> {
  /// Initialize the controller
  WorkoutController controller = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAllWorkoutTrainingListAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workout Training",
          style: TextStyle(
            fontFamily: fontInterMedium,
            fontSize: 18,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(AddWorkoutTrainingScreen(
                  workoutId:
                      controller.selectedWorkoutData.value.workoutId ?? "0",
                  isEdit: false));
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
                      color: text_color,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                )
              ],
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.workoutTrainingList.isEmpty &&
            !controller.isLoading.value) {
          return Center(
            child: Text(
              "No Workout Found",
              style: TextStyle(
                fontFamily: fontInterRegular,
                fontSize: 16,
              ),
            ),
          );
        }

        return Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.workoutTrainingList.length,
              itemBuilder: (context, mainIndex) {
                final workout = controller.workoutTrainingList[mainIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== DAY TITLE =====
                    Text(
                      "Day ${workout.day}",
                      style: TextStyle(
                          fontFamily: fontInterBold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 6),

                    // ===== CATEGORY LIST =====
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: workout.workoutList?.length ?? 0,
                      itemBuilder: (context, catIndex) {
                        final category = workout.workoutList![catIndex];

                        return ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          title: Text(
                            category.masterWorkoutName ?? "",
                            style: TextStyle(
                              fontFamily: fontInterMedium,
                              fontSize: 14,
                            ),
                          ),
                          children: [
                            // Use Column to render all child items (no nested scrolling)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                category.workoutDetailList?.length ?? 0,
                                (subIndex) {
                                  final sub =
                                      category.workoutDetailList![subIndex];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      sub.workoutDetailName ?? "",
                                      style: TextStyle(
                                        fontFamily: fontInterMedium,
                                        fontSize: 15,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        info("Sets", sub.sets ?? "0"),
                                        info("Repeat No", sub.repeatNo ?? "0"),
                                        info("Time", sub.repeatTime ?? "0"),
                                        info("Remarks", sub.remarks ?? ""),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectedWorkoutTrainingData.value =
                                controller.workoutTrainingList[mainIndex];
                            Get.to(AddWorkoutTrainingScreen(
                                workoutId: controller
                                        .workoutTrainingList[mainIndex]
                                        .workoutId ??
                                    "",
                                isEdit: true));
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.edit, color: color_primary),
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
                                controller.callDeleteWorkoutTrainingAPI(
                                  context,
                                  controller.workoutTrainingList[mainIndex]
                                          .workoutTrainingId ??
                                      "",
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

                    const SizedBox(height: 16),

                    DottedLine(
                      dashColor: Colors.grey,
                      lineThickness: 2,
                      dashLength: 4,
                      dashGapLength: 4,
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
            if (controller.isLoading.value)
              Center(
                child: CircularProgressIndicator(),
              )
          ],
        );
      }),
    );
  }

  /// small helper widget for cleaner code
  Widget info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label: ",
              style: TextStyle(
                fontFamily: fontInterMedium,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontFamily: fontInterRegular,
                fontSize: 13,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
