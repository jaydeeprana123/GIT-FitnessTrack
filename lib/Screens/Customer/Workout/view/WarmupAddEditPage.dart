import 'package:fitness_track/Screens/Customer/Measurements/model/measurement_list_model.dart';
import 'package:fitness_track/Screens/Customer/Workout/model/master_workout_list_response.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../Styles/my_font.dart';

import 'package:get/get.dart';

import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../controller/workout_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../model/warmup_list_response.dart';

class WarmupAddEditPage extends StatefulWidget {
  final bool isEdit;

  const WarmupAddEditPage({Key? key, required this.isEdit}) : super(key: key);

  @override
  State<WarmupAddEditPage> createState() => _WarmupAddEditPageState();
}

class _WarmupAddEditPageState extends State<WarmupAddEditPage> {
  final WorkoutController workoutController = Get.find<WorkoutController>();

  String? selectedMasterWorkoutId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await workoutController.getAllMasterWorkoutListAPI(context);

      if (widget.isEdit) {
        final data = workoutController.selectedWarmupData.value;
        selectedMasterWorkoutId = data.masterWorkoutId ?? "";

        workoutController.setsController.value.text = data.sets ?? "";
        workoutController.repeatNoController.value.text = data.repeatNo ?? "";
        workoutController.repeatTimeController.value.text =
            data.repeatTime ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_primary,
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          widget.isEdit?"Edit Warm up":"Add Warm up",
          style: TextStyle(
              fontFamily: fontInterMedium,
              fontSize: 16,
              color: Colors.white
          ),
        ),
        actions: [
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Workout Name Dropdown
              Padding(
                padding: EdgeInsets.only(left: 4.0, bottom: 6),
                child: Text(
                  "Warm-up Name",
                  style: TextStyle(
                    color: text_color,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: text_color, width: 0.5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Select Warm-up'),
                    ),
                    value: selectedMasterWorkoutId?.isEmpty == true
                        ? null
                        : selectedMasterWorkoutId,
                    items: workoutController.masterWorkoutDataList
                        .map((MasterWorkoutData item) =>
                            DropdownMenuItem<String>(
                              value: item.id,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  item.name ?? '',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMasterWorkoutId = value;
                      });
                    },
                  ),
                ),
              ),

              // 🔹 Sets
              _buildTextField(
                "Sets",
                workoutController.setsController.value,
                fontInterSemiBold,
                keyboardType: TextInputType.number,
              ),

              // 🔹 Repeat Number
              _buildTextField(
                "Repeat No",
                workoutController.repeatNoController.value,
                fontInterSemiBold,
                keyboardType: TextInputType.number,
              ),

              // 🔹 Repeat Time
              _buildTextField(
                "Repeat Time (hh:mm:ss)",
                workoutController.repeatTimeController.value,
                fontInterSemiBold,
                keyboardType: TextInputType.datetime,
              ),



              Container(
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 58.0, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedMasterWorkoutId == null) {
                        snackBar(context, "Select workout");
                        return;
                      }

                      workoutController.callAddEditWarmupDaysAPI(
                          context,
                          widget.isEdit
                              ? workoutController
                              .selectedWarmupData.value.id ??
                              "0"
                              : "",
                          selectedMasterWorkoutId ?? "");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: button_Color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12),
                    ),
                    child: workoutController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white): Text("SUBMIT",
                        style: TextStyle(
                            fontFamily: fontInterMedium,
                            color: Colors.white,
                            fontSize: 14)),
                  ),
                ),
              ),



              // 🔹 Submit Button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String fontFamily,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: fontFamily,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
