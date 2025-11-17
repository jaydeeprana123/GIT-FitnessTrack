import 'dart:convert';
import 'package:fitness_track/Screens/Customer/Workout/model/master_workout_list_response.dart';
import 'package:fitness_track/Screens/Customer/Workout/model/workout_sub_category_list_response.dart';
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
import '../model/warmup_list_response.dart';
import '../model/workout_training_add_edit_request.dart';
import '../view/AddWorkoutTrainingScreen.dart';

/// Controller
class WorkoutController extends GetxController {
  RxList<CategoryRowModel> categoryList = <CategoryRowModel>[].obs;

  RxList<WorkoutData> workoutList = <WorkoutData>[].obs;
  Rx<WorkoutData> selectedWorkoutData = WorkoutData().obs;
  Rx<WarmupData> selectedWarmupData = WarmupData().obs;

  Rx<WorkoutTrainingAddEditRequest> workoutTrainingAddEditRequest =
      WorkoutTrainingAddEditRequest().obs;

  RxList<MeasurementData> measurementList = <MeasurementData>[].obs;

  RxList<WarmupData> warmupList = <WarmupData>[].obs;
  RxList<MasterWorkoutData> masterWorkoutDataList = <MasterWorkoutData>[].obs;
  RxList<WorkoutSubCategoryData> workoutSubCategoryDataList =
      <WorkoutSubCategoryData>[].obs;

  Rx<CustomerLoginResponseModel> loginResponseModel =
      CustomerLoginResponseModel().obs;

  RxList<String> removedCategoryIds = <String>[].obs;

  RxList<String> removedSubCategoryIds = <String>[].obs;

  RxBool workoutListApiCall = false.obs;

  Rx<TextEditingController> workoutDayController = TextEditingController().obs;
  Rx<TextEditingController> measurementIdController =
      TextEditingController().obs;
  Rx<TextEditingController> durationController = TextEditingController().obs;
  Rx<TextEditingController> startDateController = TextEditingController().obs;
  Rx<TextEditingController> endDateController = TextEditingController().obs;
  DateTime? startDate;
  DateTime? endDate;

  /// Warm up
  var setsController = TextEditingController().obs;
  var repeatNoController = TextEditingController().obs;
  var repeatTimeController = TextEditingController().obs;

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

  /// delete warmup api call
  callDeleteWarmupAPI(BuildContext context, String id) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlDeleteWarmup;

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

          getAllWarmupListAPI(context);
        } else {
          snackBar(context, baseModel.message ?? "");
        }
      });
    } else {
      print(response.reasonPhrase);
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
            "callDeleteWorkoutAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status ?? false) {
          snackBar(context, baseModel.message ?? "");

          getAllWorkoutListAPI(context);
        } else {
          snackBar(context, baseModel.message ?? "");
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// get Master Workout list
  getAllMasterWorkoutListAPI(BuildContext context) async {
    isLoading.value = true;
    String url = urlBase + urlMasterWorkoutList;

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

    request.body = json.encode({
      "customer_id": loginResponseModel.value.data?[0].id ?? "",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    isLoading.value = false;

    printData(
        "getAllWorkoutListAPI code main ", response.statusCode.toString());

    printData("getAllWorkoutListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "getAllWorkoutListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        MasterWorkoutListResponse masterWorkoutListResponse =
            MasterWorkoutListResponse.fromJson(userModel);
        masterWorkoutDataList.value = masterWorkoutListResponse.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// get Sub category Workout list
  getAllWorkoutSubCategoryListAPI(
      BuildContext context, String masterWorkoutId, int categoryIndex) async {
    isLoading.value = true;
    String url = urlBase + urlSubCategoryWorkoutList;

    printData("urrllll", url);

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "master_workout_id": masterWorkoutId,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    isLoading.value = false;

    printData(
        "getAllWorkoutListAPI code main ", response.statusCode.toString());

    printData("getAllWorkoutListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "getAllWorkoutListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        WorkoutSubCategoryResponse workoutSubCategoryResponse =
            WorkoutSubCategoryResponse.fromJson(userModel);
        workoutSubCategoryDataList.value =
            workoutSubCategoryResponse.data ?? [];
        categoryList[categoryIndex].workoutSubCategoryDataList =
            workoutSubCategoryDataList.value;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// get Warmup list
  getAllWarmupListAPI(BuildContext context) async {
    isLoading.value = true;
    String url = urlBase + urlWarmupList;

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

    request.body = json.encode({
      "customer_id": loginResponseModel.value.data?[0].id ?? "",
      "workout_id": selectedWorkoutData.value.workoutId ?? ""
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    isLoading.value = false;

    printData(
        "getAllWorkoutListAPI code main ", response.statusCode.toString());

    printData("getAllWorkoutListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "getAllWorkoutListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        WarmupListResponse warmupListModel =
            WarmupListResponse.fromJson(userModel);
        warmupList.value = warmupListModel.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// Insert Workout days api call
  callAddEditWarmupDaysAPI(BuildContext context, String warmupId) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlAddEditWarmup;
    printData("callAddWorkoutDaysAPI url", url);
    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    printData("callAddEditWarmupDaysAPI headers", headers.toString());

    request.body = json.encode({
      "id": warmupId,
      "current_login_id": loginResponseModel.value.data?[0].id ?? "0",
      "client_id": loginResponseModel.value.data?[0].id ?? "0",
      "workout_id": selectedWorkoutData.value.workoutId ?? "",
      "master_workout_id": "32014",
      "sets": setsController.value.text,
      "repeat_no": repeatNoController.value.text,
      "repeat_time": repeatTimeController.value.text,
      "status": "0"
    });
    request.headers.addAll(headers);

    printData("callAddEditWarmupDaysAPI boddyyy", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callAddEditWarmupDaysAPI API value ${valueData}");

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

  /// Insert/Update Workout days api call
  callAddEditWorkoutTrainingAPI(
      BuildContext context, String workoutTrainingJson) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlAddEditWorkoutTraining;
    printData("callAddWorkoutDaysAPI url", url);
    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    printData("callAddEditWarmupDaysAPI headers", headers.toString());

    request.body = workoutTrainingJson;
    request.headers.addAll(headers);

    printData("callAddEditWarmupDaysAPI boddyyy", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);
    printData(runtimeType.toString(),
        "callAddEditWarmupDaysAPI status code ${response.statusCode}");
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callAddEditWarmupDaysAPI API value ${valueData}");

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
  callAddEditWorkoutDaysAPI(
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
