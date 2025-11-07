import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_track/Screens/Authentication/Login/model/employee_login_response_model.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../Authentication/Login/model/customer_login_response_model.dart';
import '../model/measurement_list_model.dart';

/// Controller
class MeasurementController extends GetxController {
  // Field labels
  final Map<String, String> fieldLabels = {
    'weight': 'Weight',
    'height': 'Height',
    'neck': 'Neck',
    'shoulder': 'Shoulder',
    'normal_chest': 'Normal Chest',
    'expanded_chest': 'Expanded Chest',
    'upper_arm': 'Upper Arm',
    'fore_arm': 'Fore Arm',
    'upper_abdomen': 'Upper Abdomen',
    'waist': 'Waist',
    'lower_abdomen': 'Lower Abdomen',
    'hips': 'Hips',
    'thigh': 'Thigh',
    'calf': 'Calf',
    'whr': 'WHR',
    'bmi': 'BMI',
    'sign': 'Sign',
    'bicep': 'Bicep',
    'tricep': 'Tricep',
    'subscapula': 'Subscapula',
    'suprailliac': 'Suprailliac',
    'total': 'Total',
    'percentage': 'Percentage',
    'health_risk': 'Health Risk',
    'low': 'Low',
    'medium': 'Medium',
    'high': 'High',
    'underweight': 'Underweight',
    'normal': 'Normal',
    'overweight': 'Overweight',
    'obese_grade_1': 'Obese Grade 1',
    'obese_grade_2': 'Obese Grade 2',
    'obese_grade_3': 'Obese Grade 3',
    'bmr': 'BMR',
  };

  final dateEditingController = TextEditingController().obs;

  // Controllers for all fields
  final Map<String, TextEditingController> fieldControllers = {};

  final formKey = GlobalKey<FormState>();

  RxList<MeasurementData> measurementList = <MeasurementData>[].obs;
  Rx<MeasurementData> selectedMeasurementData = MeasurementData().obs;

  Rx<CustomerLoginResponseModel> loginResponseModel =
      CustomerLoginResponseModel().obs;

  RxBool measurementListApiCall = false.obs;

  @override
  void onInit() {
    super.onInit();
    for (var key in fieldLabels.keys) {
      fieldControllers[key] = TextEditingController();
    }
  }

  void submit(BuildContext context) {
    if (dateEditingController.value.text.isEmpty) {
      Get.snackbar("Error", "Select Date",
          backgroundColor: Colors.red.shade100);
      return;
    }

    final data = {
      'date': dateEditingController.value.text,
    };

    fieldControllers.forEach((key, value) {
      data[key] = value.text;
    });

    print("Submitted: $data");

    Get.snackbar("Success", "Form Submitted Successfully!",
        backgroundColor: Colors.green.shade100);
  }

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref()
            .getCustomerLoginModel(SharePreData.keySaveLoginModel)) ??
        CustomerLoginResponseModel();
  }

  /// get measurement list
  getAllMeasurementListAPI(BuildContext context) async {
    measurementListApiCall.value = false;

    String url = urlBase + urlMeasurementList;

    printData("urrllll", url);

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    //
    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJtb2JpbGUiOiI5NzM3Mzg4Nzg2IiwiZW1haWwiOiJhZG1pbkBmaXRuZXNzdHJhY2tneW0uY29tIn0.2Givt7c-WtZ1h92xEoyrheqvcBsiMd9j6E8qCpCYwpw',
    //
    // };

    var request = http.Request('POST', Uri.parse(url));

    request.body = json
        .encode({"customer_id": loginResponseModel.value.data?[0].id ?? ""});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    measurementListApiCall.value = true;

    printData(
        "getAllMeasurementListAPI code main ", response.statusCode.toString());

    printData("getAllMeasurementListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "getAllMeasurementListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        MeasurementListModel measurementListModel =
            MeasurementListModel.fromJson(userModel);
        measurementList.value = measurementListModel.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// Upload body measurement data (with images if any)
  callAddBodyMeasurementAPI(
    BuildContext context,
    String? frontViewPath,
    String? backViewPath,
    String? leftViewPath,
    String? rightViewPath, // optional image files
  ) async {
    onLoading(context, "Uploading..");

    // 🔹 API URL
    String url =
        "$urlBase/member/measurement/measurement_add_edit.php"; // change as needed
    printData("callAddBodyMeasurementAPI url", url);

    // 🔹 Fetch token from shared prefs
    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("Bearer Token", token);

    // 🔹 Headers
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // 🔹 Prepare form data
    request.fields.addAll({
      'client_id': loginResponseModel.value.data?[0].id ?? "0",
      'measurement_id': '',
      'date': dateEditingController.value.text,
      'weight': fieldControllers['weight']?.text ?? '',
      'height': fieldControllers['height']?.text ?? '',
      'neck': fieldControllers['neck']?.text ?? '',
      'shoulder': fieldControllers['shoulder']?.text ?? '',
      'normal_chest': fieldControllers['normal_chest']?.text ?? '',
      'expanded_chest': fieldControllers['expanded_chest']?.text ?? '',
      'upper_arm': fieldControllers['upper_arm']?.text ?? '',
      'fore_arm': fieldControllers['fore_arm']?.text ?? '',
      'upper_abdomen': fieldControllers['upper_abdomen']?.text ?? '',
      'waist': fieldControllers['waist']?.text ?? '',
      'lower_abdomen': fieldControllers['lower_abdomen']?.text ?? '',
      'hips': fieldControllers['hips']?.text ?? '',
      'thigh': fieldControllers['thigh']?.text ?? '',
      'calf': fieldControllers['calf']?.text ?? '',
      'whr': fieldControllers['whr']?.text ?? '',
      'bmi': fieldControllers['bmi']?.text ?? '',
      'sign': fieldControllers['sign']?.text ?? '',
      'bicep': fieldControllers['bicep']?.text ?? '',
      'tricep': fieldControllers['tricep']?.text ?? '',
      'subscapula': fieldControllers['subscapula']?.text ?? '',
      'suprailliac': fieldControllers['suprailliac']?.text ?? '',
      'total': fieldControllers['total']?.text ?? '',
      'percentage': fieldControllers['percentage']?.text ?? '',
      'health_risk': fieldControllers['health_risk']?.text ?? '',
      'low': fieldControllers['low']?.text ?? '',
      'medium': fieldControllers['medium']?.text ?? '',
      'high': fieldControllers['high']?.text ?? '',
      'underweight': fieldControllers['underweight']?.text ?? '',
      'normal': fieldControllers['normal']?.text ?? '',
      'overweight': fieldControllers['overweight']?.text ?? '',
      'obese_grade_1': fieldControllers['obese_grade_1']?.text ?? '',
      'obese_grade_2': fieldControllers['obese_grade_2']?.text ?? '',
      'obese_grade_3': fieldControllers['obese_grade_3']?.text ?? '',
      'bmr': fieldControllers['bmr']?.text ?? '',
      'status': '0',
      'current_login_id': '',
    });

    // 🔹 Add images (if any)
    // 🔹 Add multiple images (if selected)
    if (frontViewPath != null && frontViewPath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('front_view', frontViewPath));
    }
    if (backViewPath != null && backViewPath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('back_view', backViewPath));
    }
    if (leftViewPath != null && leftViewPath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('left_view', leftViewPath));
    }
    if (rightViewPath != null && rightViewPath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('right_view', rightViewPath));
    }

    printData("callAddBodyMeasurementAPI headers", headers.toString());

    // 🔹 Send request
    http.StreamedResponse response = await request.send();

    Navigator.pop(context); // close loading dialog

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callInsertFavCommentAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status ?? false) {
          snackBar(context, baseModel.message ?? "");

          Navigator.pop(context);
        } else {
          snackBar(context, baseModel.message ?? "");
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    fieldControllers.forEach((key, controller) => controller.dispose());
    dateEditingController.value.dispose();
    printData("onClose", "onClose login controller");
    Get.delete<MeasurementController>();
  }
}
