import 'package:fitness_track/Screens/Customer/Workout/view/AddWorkoutTrainingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontInterMedium),
                )
              ],
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.workoutTrainingList.isEmpty) {
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

        return ListView.builder(
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
                    fontFamily: fontInterMedium,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),

                // ===== CATEGORY LIST =====
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: workout.workoutList?.length ?? 0,
                  itemBuilder: (context, catIndex) {
                    final category = workout.workoutList![catIndex];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 2,
                      child: ExpansionTile(
                        title: Text(
                          category.masterWorkoutName ?? "",
                          style: TextStyle(
                            fontFamily: fontInterMedium,
                            fontSize: 16,
                          ),
                        ),

                        // ===== SUB CATEGORY LIST =====
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: category.workoutDetailList?.length ?? 0,
                            itemBuilder: (context, subIndex) {
                              final sub = category.workoutDetailList![subIndex];

                              return ListTile(
                                title: Text(
                                  sub.workoutDetailName ?? "",
                                  style: TextStyle(
                                    fontFamily: fontInterRegular,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    info("Sets", sub.sets ?? "0"),
                                    info("Repeat No", sub.repeatNo ?? "0"),
                                    info("Time", sub.repeatTime ?? "0"),
                                    info("Remarks", sub.remarks ?? ""),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 12),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectedWorkoutTrainingData.value =
                            controller.workoutTrainingList[mainIndex];
                        Get.to(AddWorkoutTrainingScreen(
                            workoutId: controller
                                    .workoutTrainingList[mainIndex].workoutId ??
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
                          const Icon(Icons.delete_forever, color: Colors.red),
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
            );
          },
        );
      }),
    );
  }

  /// small helper widget for cleaner code
  Widget info(String label, String value) {
    return Text(
      "$label: $value",
      style: TextStyle(
        fontFamily: fontInterRegular,
        fontSize: 13,
      ),
    );
  }
}
