import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:async'; // Import for TimeoutException
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/api_response.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../CommonWidgets/internet_connection_dialog.dart';
import '../../../CommonWidgets/time_out_dialog.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Login/model/employee_login_response_model.dart';
import '../model/dashboard_counter_model.dart';

/// Controller
class DashboardController extends GetxController {
  Rx<EmployeeLoginResponseModel> loginResponseModel =
      EmployeeLoginResponseModel().obs;
  Rx<DashboardCounterModel> dashboardCounterModel = DashboardCounterModel().obs;

  RxBool isLoading = false.obs;

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPrefNew()
            .getEmployeeLoginModel(SharePreData.keySaveLoginModel)) ??
        EmployeeLoginResponseModel();
  }

  /// change password api
  callDashboardCounterAPI() async {
    isLoading.value = true;

    String url = urlBase + urlDashboardCounter;
    String token =
         MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
      'POST',
      Uri.parse(url),
    );
    request.body = json.encode({
      "emp_id": loginResponseModel.value.data?[0].id ?? "",
    });
    request.headers.addAll(headers);

    printData("request callDashboardCounterAPI", request.body);

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
      printData(runtimeType.toString(),
          "callDashboardCounterAPI API status ${response.statusCode}");

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "callDashboardCounterAPI API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          dashboardCounterModel.value =
              DashboardCounterModel.fromJson(userModel);
          if (dashboardCounterModel.value.status ?? false) {
            MySharedPrefNew().setDashboardModel(
              dashboardCounterModel.value.data?[0] ?? DashboardData(),
              SharePreData.keyDashboardData,
            );
          } else {
            // Handle other response statuses
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
            callDashboardCounterAPI(); // Retry API call // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");
      // Show a timeout error message to the user
      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            callDashboardCounterAPI(); // Retry API call
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
    Get.delete<DashboardController>();
  }
}
