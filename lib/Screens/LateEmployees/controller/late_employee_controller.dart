import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fitness_track/Screens/LateEmployees/model/late_employee_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_allotment_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_category_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_shift_list_model.dart';
import 'package:intl/intl.dart';

import 'package:fitness_track/Screens/Holidays/model/holiday_list_model.dart';
import 'package:fitness_track/Screens/Salary/model/salary_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_track/Screens/Authentication/Login/model/employee_login_response_model.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../CommonWidgets/internet_connection_dialog.dart';
import '../../../CommonWidgets/time_out_dialog.dart';
import '../../../Networks/model/base_model.dart';
import '../../DayInDayOut/model/shif_list_model.dart';

/// Controller
class LateEmployeeController extends GetxController {
  Rx<TextEditingController> remarksEditingController =
      TextEditingController().obs;
  RxList<LateEmployeeData> lateEmployeeList = <LateEmployeeData>[].obs;
  Rx<EmployeeLoginResponseModel> loginResponseModel =
      EmployeeLoginResponseModel().obs;
  Rx<TextEditingController> fromDateEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> toDateEditingController =
      TextEditingController().obs;
  RxBool isLoading = false.obs;

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPrefNew()
            .getEmployeeLoginModel(SharePreData.keySaveLoginModel)) ??
        EmployeeLoginResponseModel();
    // var now = DateTime.now();
    // var formatter = DateFormat('yyyy-MM-dd');
    // String todayDate = formatter.format(now);
    //
    // fromDateEditingController.value.text = todayDate;
    // toDateEditingController.value.text = todayDate;
  }

  /// get late employee list
  getLateEmployeeListAPI() async {
    String url = urlBase + urlLateEmployeeList;
    isLoading.value = true;
    printData("urrllll", url);

    String token =
        await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));
    DateTime now = DateTime.now();
    request.body = json.encode({
      "emp_id": loginResponseModel.value.data?[0].id ?? "",
      "branch_id": loginResponseModel.value.data?[0].branchId ?? "",
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );;
      printData(
          "getLateEmployeeListAPI code main ", response.statusCode.toString());

      printData("getLateEmployeeListAPI request.body ", request.body);
      isLoading.value = false;
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "getLateEmployeeListAPI API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          LateEmployeeListModel lateEmployeeListModel =
              LateEmployeeListModel.fromJson(userModel);
          lateEmployeeList.value = lateEmployeeListModel.data ?? [];
        });
      } else if (response.statusCode == 401) {
        goToWelcomeScreen();
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      printData(runtimeType.toString(), "No internet connection.");

      /// Show full-screen dialog for no internet
      Get.dialog(
        NoInternetDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getLateEmployeeListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getLateEmployeeListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }
  }

  /// get late employee list by date
  getLateEmployeeListByDateAPI() async {
    String url = urlBase + urlLateEmployeeListByDate;

    printData("urrllll", url);
    isLoading.value = true;
    String token =
        await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));
    DateTime now = DateTime.now();
    request.body = json.encode({
      "emp_id": loginResponseModel.value.data?[0].id ?? "",
      "branch_id": loginResponseModel.value.data?[0].branchId ?? "",
      "from_date": fromDateEditingController.value.text,
      "to_date": toDateEditingController.value.text,
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );;
      printData(
          "getLateEmployeeListAPI code main ", response.statusCode.toString());

      printData("getLateEmployeeListAPI request.body ", request.body);
      isLoading.value = false;
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "getLateEmployeeListAPI API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          LateEmployeeListModel lateEmployeeListModel =
              LateEmployeeListModel.fromJson(userModel);
          lateEmployeeList.value = lateEmployeeListModel.data ?? [];
        });
      } else if (response.statusCode == 401) {
        goToWelcomeScreen();
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      printData(runtimeType.toString(), "No internet connection.");

      /// Show full-screen dialog for no internet
      Get.dialog(
        NoInternetDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getLateEmployeeListByDateAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getLateEmployeeListByDateAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<LateEmployeeController>();
  }
}
