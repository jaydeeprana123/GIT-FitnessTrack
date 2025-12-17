import 'dart:async';
import 'dart:convert';
import 'dart:io';

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


/// Controller
class SalaryController extends GetxController {


  RxList<SalaryData> salaryList = <SalaryData>[].obs;
  Rx<SalaryData> selectedSalary = SalaryData().obs;
  Rx<EmployeeLoginResponseModel> loginResponseModel = EmployeeLoginResponseModel().obs;

  RxBool isLoading = false.obs;

  getUserInfo() async{
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPrefNew().getEmployeeLoginModel(SharePreData.keySaveLoginModel))??EmployeeLoginResponseModel();

  }

  /// get salary list
  getSalaryListAPI() async {
    isLoading.value = true;
    String url = urlBase + urlSalaryList;

    printData("urrllll", url);

    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "emp_id": loginResponseModel.value.data?[0].id??""
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

    printData("getSalaryListAPI code main ", response.statusCode.toString());

    printData("getSalaryListAPI request.body ", request.body);
    isLoading.value = false;
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getSalaryListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        SalaryListModel salaryListModel = SalaryListModel.fromJson(userModel);
        salaryList.value = salaryListModel.data ?? [];
      });
    }else if (response.statusCode == 401) {

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
            getSalaryListAPI(); // Retry API call // Retry API call
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
            getSalaryListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error",  "An unexpected error occurred. Please try again.");
    }
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();


    printData("onClose", "onClose login controller");
    Get.delete<SalaryController>();
  }
}
