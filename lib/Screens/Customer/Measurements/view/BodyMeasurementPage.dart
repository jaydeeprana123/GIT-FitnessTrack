import 'dart:developer';
import 'package:intl/intl.dart';
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyMeasurementPage extends StatefulWidget {
  const BodyMeasurementPage({Key? key}) : super(key: key);

  @override
  State<BodyMeasurementPage> createState() => _BodyMeasurementPageState();
}

class _BodyMeasurementPageState extends State<BodyMeasurementPage> {
  final _formKey = GlobalKey<FormState>();
  final MeasurementController controller = Get.put(MeasurementController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body Measurement Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("SELECT DATE"),
            _buildDatePicker(context),

            // Auto-generate measurement fields
            ...controller.fieldLabels.entries.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(e.value),
                  _buildInputField(
                      controller.fieldControllers[e.key]!, e.value),
                ],
              );
            }).toList(),

            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 58.0, vertical: 20),
                child: ElevatedButton(
                  onPressed: () => controller.submit(context),
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
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
            controller.dateEditingController.value.text =
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
            controller.dateEditingController.value.text.isEmpty
                ? ""
                : controller.dateEditingController.value.text,
            style: TextStyle(
              color: controller.dateEditingController.value.text.isEmpty
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
