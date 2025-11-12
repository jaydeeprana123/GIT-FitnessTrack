import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_details_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditMeasurementPage extends StatefulWidget {
  final bool isEdit;

  const AddEditMeasurementPage({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<AddEditMeasurementPage> createState() => _AddEditMeasurementPageState();
}

class _AddEditMeasurementPageState extends State<AddEditMeasurementPage> {
  final _formKey = GlobalKey<FormState>();
  final MeasurementController measureController =
      Get.put(MeasurementController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isEdit) {

      WidgetsBinding.instance.addPostFrameCallback((_) async{
        await measureController.fillMeasurementControllers(measureController.selectedMeasurementData.value);
        setState(() {

        });
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: color_primary,
        title: Text(
          "Add Measurement",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: fontInterRegular),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("SELECT DATE"),
            _buildDatePicker(context),

            // Auto-generate measurement fields
            ...measureController.fieldLabels.entries.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (e.key == "tricep") _buildBoldTitle("Fat Percentage"),
                  if (e.key == "health_risk")
                    _buildBoldTitle("WHR (Waist To Hip Ratio)"),
                  if (e.key == "underweight")
                    _buildBoldTitle("BMI (Body Mass Index)"),
                  if (e.key == "bmr")
                    _buildBoldTitle("BMR (Basal Metabolic Rate)"),
                  Row(
                    children: [
                      Expanded(flex: 1, child: _buildTitle(e.value)),
                      Expanded(
                        flex: 2,
                        child: _buildInputField(
                            measureController.fieldControllers[e.key]!,
                            e.value),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              );
            }).toList(),

            const SizedBox(height: 25),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        measureController.frontViewImagePath.value =
                            await selectPhoto(context, true);

                        printData("controller.imagePath.value",
                            measureController.frontViewImagePath.value);
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(58.r),
                              child:
                                  // controller.imagePath.value.isNotEmpty
                                  //     ?

                                  (measureController
                                          .frontViewImagePath.value.isNotEmpty)
                                      ? Image.file(
                                          File(measureController
                                              .frontViewImagePath.value),
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                      : DottedBorder(
                                          dashPattern: [6, 3],
                                          strokeWidth: 1.5,
                                          color: hint_txt_909196,
                                          borderType: BorderType.Circle,
                                          radius: Radius.circular(50),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: line_gray_e2e2e6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  icon_add_plus_square_new,
                                                  height: 20,
                                                  width: 20,
                                                  color: text_color,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text("Add",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff3e4046),
                                                        fontFamily:
                                                            fontInterSemiBold,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                          ),
                                        )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Front View",
                            style: TextStyle(
                                color: text_color,
                                fontSize: 14,
                                fontFamily: fontInterMedium),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        measureController.backViewImagePath.value =
                            await selectPhoto(context, true);

                        printData("controller.imagePath.value",
                            measureController.backViewImagePath.value);
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(58.r),
                              child:
                                  // controller.imagePath.value.isNotEmpty
                                  //     ?

                                  (measureController
                                          .backViewImagePath.value.isNotEmpty)
                                      ? Image.file(
                                          File(measureController
                                              .backViewImagePath.value),
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                      : DottedBorder(
                                          dashPattern: [6, 3],
                                          strokeWidth: 1.5,
                                          color: hint_txt_909196,
                                          borderType: BorderType.Circle,
                                          radius: Radius.circular(50),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: line_gray_e2e2e6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  icon_add_plus_square_new,
                                                  height: 20,
                                                  width: 20,
                                                  color: text_color,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text("Add",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff3e4046),
                                                        fontFamily:
                                                            fontInterSemiBold,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                          ),
                                        )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Back View",
                            style: TextStyle(
                                color: text_color,
                                fontSize: 14,
                                fontFamily: fontInterMedium),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        measureController.leftViewImagePath.value =
                            await selectPhoto(context, true);

                        printData("controller.imagePath.value",
                            measureController.leftViewImagePath.value);
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(58.r),
                              child:
                                  // controller.imagePath.value.isNotEmpty
                                  //     ?

                                  (measureController
                                          .leftViewImagePath.value.isNotEmpty)
                                      ? Image.file(
                                          File(measureController
                                              .leftViewImagePath.value),
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                      : DottedBorder(
                                          dashPattern: [6, 3],
                                          strokeWidth: 1.5,
                                          color: hint_txt_909196,
                                          borderType: BorderType.Circle,
                                          radius: Radius.circular(50),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: line_gray_e2e2e6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  icon_add_plus_square_new,
                                                  height: 20,
                                                  width: 20,
                                                  color: text_color,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text("Add",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff3e4046),
                                                        fontFamily:
                                                            fontInterSemiBold,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                          ),
                                        )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Left View",
                            style: TextStyle(
                                color: text_color,
                                fontSize: 14,
                                fontFamily: fontInterMedium),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        measureController.rightViewImagePath.value =
                            await selectPhoto(context, true);

                        printData("controller.imagePath.value",
                            measureController.rightViewImagePath.value);
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(58.r),
                              child:
                                  // controller.imagePath.value.isNotEmpty
                                  //     ?

                                  (measureController
                                          .rightViewImagePath.value.isNotEmpty)
                                      ? Image.file(
                                          File(measureController
                                              .rightViewImagePath.value),
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                      : DottedBorder(
                                          dashPattern: [6, 3],
                                          strokeWidth: 1.5,
                                          color: hint_txt_909196,
                                          borderType: BorderType.Circle,
                                          radius: Radius.circular(50),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: line_gray_e2e2e6),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  icon_add_plus_square_new,
                                                  height: 20,
                                                  width: 20,
                                                  color: text_color,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text("Add",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff3e4046),
                                                        fontFamily:
                                                            fontInterSemiBold,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                          ),
                                        )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Right View",
                            style: TextStyle(
                                color: text_color,
                                fontSize: 14,
                                fontFamily: fontInterMedium),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 58.0, vertical: 20),
                child: ElevatedButton(
                  onPressed: () => measureController.submit(context, widget.isEdit?measureController.selectedMeasurementData.value.measurementId??"0":""),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: button_Color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                  ),
                  child: const Text("SUBMIT",
                      style: TextStyle(
                          fontFamily: fontInterMedium,
                          color: Colors.white,
                          fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 8, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: text_color,
          fontSize: 14,
          fontFamily: fontInterBold,
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 2, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: text_color,
          fontSize: 12,
          fontFamily: fontInterMedium,
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(11)),
        border: Border.all(width: 1, color: line_gray_e2e2e6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (controller == measureController.fieldControllers['waist'] ||
                controller == measureController.fieldControllers['hips']) {
              setState(() {
                measureController.calculateWHR();
              });
            } else if (controller ==
                    measureController.fieldControllers['bicep'] ||
                controller == measureController.fieldControllers['tricep'] ||
                controller ==
                    measureController.fieldControllers['subscapula'] ||
                controller ==
                    measureController.fieldControllers['suprailliac']) {
              setState(() {
                measureController.calculateTotalBodyFatSkinfold();
              });
            } else if (controller ==
                    measureController.fieldControllers['weight'] ||
                controller == measureController.fieldControllers['height']) {
              setState(() {
                measureController.calculateBMR();
              });
            }
          },
          style: const TextStyle(
            color: text_color,
            fontWeight: FontWeight.w500,
            fontFamily: fontInterMedium,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            hintText: hint,
            hintStyle: const TextStyle(
              color: hint_txt_909196,
              fontWeight: FontWeight.w500,
              fontFamily: fontInterRegular,
              fontSize: 13,
            ),
            border: InputBorder.none,
          ),
          keyboardType: (controller ==
                      measureController.fieldControllers['low'] ||
                  controller == measureController.fieldControllers['medium'] ||
                  controller == measureController.fieldControllers['high'] ||
                  controller ==
                      measureController.fieldControllers['underweight'] ||
                  controller == measureController.fieldControllers['normal'] ||
                  controller ==
                      measureController.fieldControllers['overweight'] ||
                  controller ==
                      measureController.fieldControllers['obese_grade_1'] ||
                  controller ==
                      measureController.fieldControllers['obese_grade_2'] ||
                  controller ==
                      measureController.fieldControllers['obese_grade_3'] ||
                  controller == measureController.fieldControllers['sign'])
              ? TextInputType.text
              : TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
          ],
          cursorColor: text_color,
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () async {
          FocusScope.of(context).unfocus();
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            measureController.dateEditingController.value.text =
                DateFormat('dd-MM-yyyy').format(picked);
          }
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(width: 1, color: line_gray_e2e2e6),
          ),
          child: Text(
            measureController.dateEditingController.value.text.isEmpty
                ? ""
                : measureController.dateEditingController.value.text,
            style: TextStyle(
              color: measureController.dateEditingController.value.text.isEmpty
                  ? hint_txt_909196
                  : subtitle_black_101623,
              fontFamily: fontInterMedium,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}
