import 'package:fitness_track/Screens/Customer/Workout/model/master_workout_list_response.dart';
import 'package:fitness_track/Screens/Customer/Workout/model/workout_sub_category_list_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../controller/workout_controller.dart';

class AddWorkoutTrainingScreen extends StatefulWidget {
  @override
  State<AddWorkoutTrainingScreen> createState() =>
      _AddWorkoutTrainingScreenState();
}

class _AddWorkoutTrainingScreenState extends State<AddWorkoutTrainingScreen> {
  final WorkoutController workoutController = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();

    workoutController.getAllMasterWorkoutListAPI(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Add Workout Training",
          style: TextStyle(
            fontFamily: fontInterSemiBold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                /// CATEGORY LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: workoutController.categoryList.length,
                  itemBuilder: (context, index) => _buildCategoryRow(index),
                ),

                const SizedBox(height: 16),

                /// ADD CATEGORY BUTTON
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color_primary,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      workoutController.categoryList.add(CategoryRowModel());
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    "Add Category",
                    style: TextStyle(
                      fontFamily: fontInterSemiBold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  /// CATEGORY ROW UI
  Widget _buildCategoryRow(int index) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 20),
      shadowColor: Colors.black12,
      color: color_primary_transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// CATEGORY LABEL

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 2),
                  child: Text("Category",
                      style: TextStyle(
                          color: text_color,
                          fontSize: 12,
                          fontFamily: fontInterMedium)),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: text_color, width: 0.5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _addDividersAfterItems(
                          workoutController.masterWorkoutDataList ?? []),
                      value: workoutController.categoryList[index].categoryId,
                      onChanged: (String? value) {
                        setState(() {
                          workoutController.categoryList[index].categoryId =
                              value;

                          workoutController.getAllWorkoutSubCategoryListAPI(
                              context, value ?? "", index);
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
                            workoutController.masterWorkoutDataList.length),
                      ),
                      iconStyleData: const IconStyleData(
                        openMenuIcon: Icon(Icons.arrow_drop_up),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            /// SUB CATEGORY LIST
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  workoutController.categoryList[index].subCategories.length,
              itemBuilder: (context, subIndex) => _buildSubCategoryRow(
                  workoutController.categoryList[index], subIndex),
            ),

            SizedBox(height: 10),

            /// ADD SUB CATEGORY BUTTON
            TextButton.icon(
              onPressed: () {
                setState(() {
                  workoutController.categoryList[index]
                    ..subCategories.add(SubCategoryModel());
                });
              },
              icon: Icon(Icons.add, color: color_primary),
              label: Text(
                "Add Sub Category",
                style: TextStyle(
                  fontFamily: fontInterSemiBold,
                  fontSize: 14,
                  color: color_primary,
                ),
              ),
            ),

            SizedBox(height: 10),

            /// REMOVE CATEGORY
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    workoutController.categoryList.removeAt(index);
                  });
                },
                icon: Icon(Icons.delete, color: Colors.red),
                label: Text(
                  "Remove Category",
                  style: TextStyle(
                    fontFamily: fontInterSemiBold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SUB CATEGORY ROW UI
  Widget _buildSubCategoryRow(CategoryRowModel category, int subIndex) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Workout Detail",
              style: TextStyle(
                fontFamily: fontInterSemiBold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 6),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: text_color, width: 0.5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select Workout Detail',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: _addDividersForSubCategory(
                      category.workoutSubCategoryDataList ?? []),
                  value: category.subCategories[subIndex].workoutDetailId,
                  onChanged: (String? value) {
                    setState(() {
                      category.subCategories[subIndex].workoutDetailId = value;
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
                        category.workoutSubCategoryDataList.length),
                  ),
                  iconStyleData: const IconStyleData(
                    openMenuIcon: Icon(Icons.arrow_drop_up),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: buildTextField("Sets",
                        (v) => category.subCategories[subIndex].sets = v)),
                Expanded(
                    child: buildTextField("Repeat No",
                        (v) => category.subCategories[subIndex].repeatNo = v)),
                Expanded(
                    child: buildTextField(
                        "Repeat Time",
                        (v) =>
                            category.subCategories[subIndex].repeatTime = v)),
              ],
            ),
            buildTextField(
                "Remarks", (v) => category.subCategories[subIndex].remarks = v),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  setState(() => category.subCategories.removeAt(subIndex));
                },
                icon: Icon(Icons.delete, color: Colors.red),
                label: Text(
                  "Remove",
                  style: TextStyle(
                    fontFamily: fontInterRegular,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// COMMON TEXTFIELD
  Widget buildTextField(String label, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: fontInterSemiBold,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        TextFormField(
          decoration: inputDecoration(label),
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          style: TextStyle(fontFamily: fontInterRegular),
        ),
        SizedBox(height: 12)
      ],
    );
  }

  /// COMMON INPUT DECORATION
  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade200,
      labelText: label,
      labelStyle: TextStyle(
        fontFamily: fontInterRegular,
        fontSize: 14,
        color: Colors.black54,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<MasterWorkoutData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final MasterWorkoutData item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.name ?? "",
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

  List<DropdownMenuItem<String>> _addDividersForSubCategory(
      List<WorkoutSubCategoryData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final WorkoutSubCategoryData item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.name ?? "",
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

/// MODELS
class CategoryRowModel {
  String? categoryId;
  String? workoutId;
  List<SubCategoryModel> subCategories = [];
  List<WorkoutSubCategoryData> workoutSubCategoryDataList = [];
}

class SubCategoryModel {
  String? workoutDetailId;
  String sets = "0";
  String repeatNo = "0";
  String repeatTime = "0";
  String remarks = "";
}
