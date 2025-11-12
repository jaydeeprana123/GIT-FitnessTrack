import 'package:fitness_track/Screens/Customer/Measurements/model/measurement_list_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:get/get.dart';

import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../controller/workout_controller.dart';

class WorkoutAddEditPage extends StatefulWidget {
  final bool isEdit;

  const WorkoutAddEditPage({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<WorkoutAddEditPage> createState() => _WorkoutAddEditPageState();
}

class _WorkoutAddEditPageState extends State<WorkoutAddEditPage> {
  final WorkoutController workoutController = Get.find<WorkoutController>();
  String? strSelectedMeasurement;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workoutController.getAllMeasurementListAPI(context);
    if (widget.isEdit) {
      strSelectedMeasurement =
          workoutController.selectedWorkoutData.value.measurementId ?? "";

      workoutController.startDateController.value.text =
          getDateOnlyInIndianFormat(
              workoutController.selectedWorkoutData.value.workoutDate ??
                  DateTime(2025));
      workoutController.endDateController.value.text =
          getDateOnlyInIndianFormat(
              workoutController.selectedWorkoutData.value.dueDate ??
                  DateTime(2025));
      workoutController.durationController.value.text =
          workoutController.selectedWorkoutData.value.durationInDays ?? "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit == "1" ? "Edit Workout" : "Add Workout"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, bottom: 2),
                    child: Text("Select Measurement",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 12,
                            fontFamily: fontInterMedium)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: text_color, width: 0.5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Measurement',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: _addDividersAfterItems(
                            workoutController.measurementList ?? []),
                        value: strSelectedMeasurement,
                        onChanged: (String? value) {
                          setState(() {
                            strSelectedMeasurement = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          customHeights: _getCustomItemsHeights(
                              workoutController.measurementList.length),
                        ),
                        iconStyleData: const IconStyleData(
                          openMenuIcon: Icon(Icons.arrow_drop_up),
                        ),
                      ),

                      // DropdownButton2(
                      //
                      //   isExpanded: true,
                      //   offset: const Offset(0, -3),
                      //
                      //   icon: Container(
                      //     padding: EdgeInsets.only(right: 10.w),
                      //     child: SvgPicture.asset(
                      //       icon_down_arrow,
                      //       color: text_color,
                      //     ),
                      //   ),
                      //   hint: Container(
                      //     padding: EdgeInsets.only( right: 14),
                      //     child: Text(
                      //       'Select State',
                      //       style: TextStyle(
                      //           color: text_color,
                      //           fontFamily: fontInterRegular,
                      //           fontSize: 14),
                      //
                      //       overflow: TextOverflow.ellipsis,
                      //     ),
                      //   ),
                      //   items: (controller.stateList ?? [])
                      //       .isNotEmpty
                      //       ? (controller.stateList.value ?? [])
                      //       .map((StateData value) =>
                      //       DropdownMenuItem<String>(
                      //         value: value.id.toString(),
                      //
                      //         child: Container(
                      //           padding:
                      //           EdgeInsets.only(right: 14),
                      //           // color: Colors.red,
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius:
                      //             BorderRadius.all(Radius.circular(11.r)),
                      //             border: Border.all(width: 0.5, color: Colors.white),
                      //           ),
                      //           child: Text(
                      //             value.name??"",
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               fontFamily: fontInterMedium,
                      //               color: Colors.black,
                      //             ),
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         ),
                      //       ))
                      //       .toList()
                      //       : <String>[].map((String value) {
                      //     return const DropdownMenuItem<String>(
                      //       value: "",
                      //       child: SizedBox(),
                      //     );
                      //   }).toList(),
                      //   value: strSelectedState,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       if(strSelectedState != value as String){
                      //         strSelectedState = value;
                      //         strSelectedCity = null;
                      //         strSelectedArea = null;
                      //
                      //         printData("strSelectedState",
                      //             strSelectedState ?? "");
                      //
                      //         controller.getCityList(context, strSelectedState??"");
                      //
                      //
                      //       }
                      //     });
                      //   },
                      //   // buttonHeight: 40,
                      //   // buttonWidth: 140,
                      //   // itemHeight: 40,
                      //   dropdownMaxHeight: 175,
                      //   scrollbarThickness: 3,
                      //   scrollbarAlwaysShow: true,
                      //   // dropdownWidth: double.infinity,
                      // ),
                    ),
                  ),
                ],
              ),
              _buildDatePicker(context, "Start Date (dd-MM-yyyy)",
                  workoutController.startDateController.value, true),
              _buildDatePicker(context, "End Date (dd-MM-yyyy)",
                  workoutController.endDateController.value, false),
              _buildField("Duration (in weeks)",
                  workoutController.durationController.value,
                  readOnly: true),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: workoutController.isLoading.value
                      ? null
                      : () {
                          workoutController.callAddWorkoutDaysAPI(
                              context,
                              strSelectedMeasurement ?? "",
                              widget.isEdit
                                  ? workoutController.selectedWorkoutData.value
                                          .workoutId ??
                                      "0"
                                  : "");
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: workoutController.isLoading.value
                      ? const CircularProgressIndicator(color: color_primary)
                      : const Text(
                          "SUBMIT",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  /// 📅 Build Date Picker Field
  Widget _buildDatePicker(BuildContext context, String label,
      TextEditingController controller, bool isStartDate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon:
              const Icon(Icons.calendar_today, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onTap: () async {
          FocusScope.of(context).unfocus();

          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            workoutController.setDate(isStartDate, pickedDate);
          }
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<MeasurementData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final MeasurementData item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.measurementId,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                getDateIndMMYYYYFormat(item.date ?? DateTime(2025)),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights(int lengthOfArray) {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (lengthOfArray * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }
}
