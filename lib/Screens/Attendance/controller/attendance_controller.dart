import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitness_track/CommonWidgets/time_out_dialog.dart';
import 'package:fitness_track/Enums/attendance_type_status_enum.dart';
import 'package:intl/intl.dart';
import 'package:fitness_track/Screens/Attendance/model/attendance_list_model.dart';
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
import '../model/employee_attendance_list_model.dart';

/// Controller
class AttendanceController extends GetxController {
  Rx<TextEditingController> fromDateEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> toDateEditingController =
      TextEditingController().obs;
  RxList<AttendanceData> attendanceList = <AttendanceData>[].obs;
  RxList<EmployeeAttendanceData> employeeAttendanceList =
      <EmployeeAttendanceData>[].obs;
  Rx<EmployeeLoginResponseModel> loginResponseModel =
      EmployeeLoginResponseModel().obs;

  RxBool isLoading = false.obs;

  getUserInfo(bool isShowTodayAttendance) async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref()
            .getEmployeeLoginModel(SharePreData.keySaveLoginModel)) ??
        EmployeeLoginResponseModel();

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String todayDate = formatter.format(now);

    DateTime oneYearBefore = DateTime(
      now.year,
      now.month,
      1,
    );

    String oneYearBeforeDate = formatter.format(oneYearBefore);

    if (isShowTodayAttendance) {
      fromDateEditingController.value.text = todayDate;
    } else {
      fromDateEditingController.value.text = oneYearBeforeDate;
    }

    toDateEditingController.value.text = todayDate;
  }

  /// get Attendance list
  getAttendanceListAPI(String attendanceType) async {
    isLoading.value = true;

    attendanceList.clear();
    String url = urlBase + urlAttendanceList;

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
      "emp_id": loginResponseModel.value.data?[0].id ?? "",
      "start_date": fromDateEditingController.value.text,
      "end_date": toDateEditingController.value.text,
      "late_punch":
          attendanceType == AttendanceTypeEnum.lateMark.outputVal ? "1" : "0",
      "over_time":
          attendanceType == AttendanceTypeEnum.overTime.outputVal ? "1" : "0",
      "absent":
          attendanceType == AttendanceTypeEnum.absent.outputVal ? "1" : "0",
    });

    printData("request.body", request.body);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        },
      );

      isLoading.value = false;
      printData(
          "getAttendanceListAPI code main ", response.statusCode.toString());

      printData("getAttendanceListAPI request.body ", request.body);

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "getAttendanceListAPI place API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          AttendanceListModel attendanceListModel =
              AttendanceListModel.fromJson(userModel);
          attendanceList.value = attendanceListModel.data ?? [];
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
            getAttendanceListAPI(attendanceType); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for no internet
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getAttendanceListAPI(attendanceType); // Retry API call
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

  /// get Employee Attendance list
  getEmployeeAttendanceListAPI() async {
    isLoading.value = true;
    employeeAttendanceList.clear();

    String url = urlBase + urlEmployeeAttendanceList;

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
      "emp_id": loginResponseModel.value.data?[0].id ?? "",
      "start_date": fromDateEditingController.value.text,
      "end_date": toDateEditingController.value.text,
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        },
      );

      isLoading.value = false;

      printData("getEmployeeAttendanceListAPI code main ",
          response.statusCode.toString());

      printData("getEmployeeAttendanceListAPI request.body ", request.body);

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "getEmployeeAttendanceListAPI place API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          EmployeeAttendanceListModel employeeAttendanceListModel =
              EmployeeAttendanceListModel.fromJson(userModel);

          if (employeeAttendanceListModel.status??false) {
            employeeAttendanceList.value =
                employeeAttendanceListModel.data ?? [];
          }
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
            getEmployeeAttendanceListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for no internet
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getEmployeeAttendanceListAPI(); // Retry API call
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

  /// get Branch Wise Attendance list
  getBranchWiseAttendanceListAPI(String branchId) async {
    // onLoading(context, "Loading..");
    isLoading.value = true;
    employeeAttendanceList.clear();
    String url = urlBase + urlBranchWiseAttendanceList;

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
      "branch_id": branchId,
      "start_date": fromDateEditingController.value.text,
      "end_date": toDateEditingController.value.text,
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        },
      );
      isLoading.value = false;
      // Navigator.pop(context);

      printData("getBranchWiseAttendanceListAPI code main ",
          response.statusCode.toString());

      printData("getBranchWiseAttendanceListAPI request.body ", request.body);

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "getBranchWiseAttendanceListAPI place API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          EmployeeAttendanceListModel employeeAttendanceListModel =
              EmployeeAttendanceListModel.fromJson(userModel);

          if (employeeAttendanceListModel.status??false) {
            employeeAttendanceList.value =
                (employeeAttendanceListModel.data ?? []);
          }
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
            getEmployeeAttendanceListAPI(); // Retry API call
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
            getEmployeeAttendanceListAPI(); // Retry API call
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
    Get.delete<AttendanceController>();
  }
}
