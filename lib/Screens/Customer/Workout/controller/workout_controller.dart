import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fitness_track/Screens/Customer/Workout/model/workout_list_model.dart';
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
import '../../Measurements/model/measurement_list_model.dart';

/// Controller
class WorkoutController extends GetxController {
  RxList<WorkoutData> workoutList = <WorkoutData>[].obs;
  Rx<WorkoutData> selectedWorkoutData = WorkoutData().obs;
  RxList<MeasurementData> measurementList = <MeasurementData>[].obs;

  Rx<CustomerLoginResponseModel> loginResponseModel =
      CustomerLoginResponseModel().obs;

  RxBool workoutListApiCall = false.obs;

  Rx<TextEditingController> clientIdController = TextEditingController().obs;
  Rx<TextEditingController> measurementIdController =
      TextEditingController().obs;
  Rx<TextEditingController> durationController = TextEditingController().obs;
  Rx<TextEditingController> startDateController = TextEditingController().obs;
  Rx<TextEditingController> endDateController = TextEditingController().obs;
  DateTime? startDate;
  DateTime? endDate;

  RxBool isLoading = false.obs;

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref()
            .getCustomerLoginModel(SharePreData.keySaveLoginModel)) ??
        CustomerLoginResponseModel();
  }

  /// Called when selecting start or end date
  void setDate(bool isStart, DateTime date) {
    final formatted = DateFormat('dd-MM-yyyy').format(date);

    if (isStart) {
      startDate = date;
      startDateController.value.text = formatted;
    } else {
      endDate = date;
      endDateController.value.text = formatted;
    }

    _calculateDuration();
  }

  /// Calculate weeks between start and end date
  void _calculateDuration() {
    if (startDate != null && endDate != null) {
      final diff = endDate!.difference(startDate!).inDays;
      final weeks = (diff / 7).ceil(); // round up partial weeks
      durationController.value.text = weeks.toString();
    }
  }

  /// delete workout api call
  callDeleteWorkoutAPI(BuildContext context, String id) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlDeleteWorkout;

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'BeeyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJtb2JpbGUiOiI5NzM3Mzg4Nzg2IiwiZW1haWwiOiJhZG1pbkBmaXRuZXNzdHJhY2tneW0uY29tIn0.2Givt7c-Wtarer Z1h92xEoyrheqvcBsiMd9j6E8qCpCYwpw',
    //
    // };

    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "id": id,
    });
    request.headers.addAll(headers);

    printData("boddyyy", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callInsertFavCommentAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status ?? false) {
          snackBar(context, baseModel.message ?? "");

          getAllMeasurementListAPI(context);
        } else {
          snackBar(context, baseModel.message ?? "");
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// get measurement list
  getAllMeasurementListAPI(BuildContext context) async {
    isLoading.value = true;

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

    isLoading.value = false;

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

  /// get Workout list
  getAllWorkoutListAPI(BuildContext context) async {
    workoutListApiCall.value = false;
    String url = urlBase + urlWorkoutList;

    printData("urrllll", url);

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
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

    workoutListApiCall.value = true;

    printData(
        "getAllWorkoutListAPI code main ", response.statusCode.toString());

    printData("getAllWorkoutListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "getAllWorkoutListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        WorkoutListModel workoutListModel =
            WorkoutListModel.fromJson(userModel);
        workoutList.value = workoutListModel.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// Insert Workout days api call
  callAddWorkoutDaysAPI(
      BuildContext context, String measurementId, String workoutId) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlAddEditWorkout;
    printData("callAddWorkoutDaysAPI url", url);
    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    printData("callAddWorkoutDaysAPI headers", headers.toString());

    request.body = json.encode({
      "client_id": loginResponseModel.value.data?[0].id ?? "0",
      "measurement_id": measurementId,
      "current_login_id": loginResponseModel.value.data?[0].id ?? "0",
      "workout_id": workoutId,
      "choice": 1,
      "duration": durationController.value.text,
      "start_date": startDateController.value.text,
      "end_date": endDateController.value.text,
      "emp_workout_id": 0,
      "status": 0
    });
    request.headers.addAll(headers);

    printData("callBookAppointmentAPI boddyyy", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

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

    printData("onClose", "onClose login controller");
    Get.delete<WorkoutController>();
  }
}
