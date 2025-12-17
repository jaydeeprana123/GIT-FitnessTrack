import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import '../model/membership_list_model.dart';


/// Controller
class MembershipController extends GetxController {

  RxBool isLoading = false.obs;
  RxList<MembershipData> membershipList = <MembershipData>[].obs;
  Rx<EmployeeLoginResponseModel> loginResponseModel = EmployeeLoginResponseModel().obs;
  getUserInfo() async{
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref().getEmployeeLoginModel(SharePreData.keySaveLoginModel))??EmployeeLoginResponseModel();

  }

  /// get Membership list
  getMembershipListAPI() async {
     isLoading.value = true;

    String url = urlBase + urlMembershipList;

    printData("urrllll", url);

    String token = await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "customer_id": loginResponseModel.value.data?[0].id??""
    });
    request.headers.addAll(headers);

    try{
    http.StreamedResponse response = await request.send();

    isLoading.value = false;

    printData("getHolidayListAPI code main ", response.statusCode.toString());

    printData("getHolidayListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getHolidayListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        MembershipListModel membeshipListModel = MembershipListModel.fromJson(userModel);
        membershipList.value = membeshipListModel.data ?? [];
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
            getMembershipListAPI(); // Retry API call
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
            getMembershipListAPI(); // Retry API call
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
    Get.delete<MembershipController>();
  }
}
