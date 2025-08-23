import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitness_track/Enums/user_type_enum.dart';
import 'package:fitness_track/Screens/Authentication/Login/view/terms_condition_view.dart';
import 'package:fitness_track/Screens/DayInDayOut/view/day_in_out_view_demo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../CommonWidgets/internet_connection_dialog.dart';
import '../../../../CommonWidgets/time_out_dialog.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../BottomNavigation/view/bottom_navigation_view.dart';
import '../model/employee_login_response_model.dart';
import '../view/employee_otp_verification_view.dart';

/// Controller
class EmployeeLoginController extends GetxController {
  /// Editing controller for text field
  Rx<TextEditingController> mobileNoEditingController =
      TextEditingController().obs;
  Rx<EmployeeLoginResponseModel> loginResponseModel = EmployeeLoginResponseModel().obs;

  RxBool isPolicyAccepted = false.obs;
  String? deviceToken;
  Rx<TextEditingController> otpText = TextEditingController().obs;

  RxBool isLoading = false.obs;

  getUserInfo() async{
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref().getEmployeeLoginModel(SharePreData.keySaveLoginModel))??EmployeeLoginResponseModel();

  }

  /// Send OTP api call
  callSendOTPAPI() async {
    isLoading.value = true;

    String url = urlBase + urlSendOtp;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "otp": "",
      "otp_type": "0",
      "mobile": mobileNoEditingController.value.text,
      "device_token": deviceToken
    });
    request.headers.addAll(headers);
    printData("request.body ", request.body );

    try{
    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    isLoading.value = false;
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "Login API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status??false) {
          Get.to(OtpVerificationView());
        } else {

          Get.snackbar("Error", baseModel.message??"");
        }
      });
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
            callSendOTPAPI(); // Retry API call
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
            callSendOTPAPI(); // Retry API call
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

  /// ReSend OTP api call
  callResendSendOTPAPI() async {

    isLoading.value = true;

    String url = urlBase + urlSendOtp;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "otp": "",
      "otp_type": "1",
      "mobile": mobileNoEditingController.value.text,
      "device_token": deviceToken
    });
    request.headers.addAll(headers);

    printData("request.body ", request.body );

    try{
    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );
     isLoading.value = false;
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "Login API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status ?? false) {

        } else {

          Get.snackbar("Error", baseModel.message??"");
        }
      });
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
            callResendSendOTPAPI(); // Retry API call
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
            callResendSendOTPAPI(); // Retry API call
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

  /// call OTP verify api call
  callVerifyOtpAPI(String otpTxtFill) async {
    isLoading.value = true;

    String url = urlBase + urlSendOtp;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "otp": otpTxtFill,
      "otp_type": "2",
      "mobile": mobileNoEditingController.value.text,
      "device_token": deviceToken
    });
    request.headers.addAll(headers);

    printData("request.body ", request.body );

    try{
    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );
     isLoading.value = false;
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "Login API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
         loginResponseModel.value = EmployeeLoginResponseModel.fromJson(userModel);

        if (loginResponseModel.value.status ?? false) {
          /// Set login model into shared preference
         await MySharedPref().setString(SharePreData.keyUserType, UserTypeEnum.employee.outputVal);
          await MySharedPref().setEmployeeLoginModel(loginResponseModel.value, SharePreData.keySaveLoginModel);
          await MySharedPref().setString(SharePreData.keyAccessToken, loginResponseModel.value.accessToken??"");

          if((loginResponseModel.value.data?[0].termsAndConditionAccept??"false") == "true"){
         //   Get.offAll(DayInOutViewDemo());

            Get.offAll(BottomNavigationView(selectTabPosition: 0));
          }else{
            Get.offAll(TermsAndConditionView());
          }

        } else {

          Get.snackbar("Error",  loginResponseModel.value.message ?? "");
        }
      });
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
            callVerifyOtpAPI(otpTxtFill); // Retry API call
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
            callVerifyOtpAPI(otpTxtFill); // Retry API call
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

  /// When employee accept the terms and condition
  callSubmitTermsAndConditionDoneAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlUpdateTermsAndCondition;

    printData("urrllll", url);

    String token = await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "emp_id":loginResponseModel.value.data?[0].id??"",
      "terms_and_condition":"1"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    Navigator.pop(context);

    printData("callSubmitTermsAndConditionDoneAPI code main ", response.statusCode.toString());

    printData("callSubmitTermsAndConditionDoneAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "callSubmitTermsAndConditionDoneAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        loginResponseModel.value = EmployeeLoginResponseModel.fromJson(userModel);

        if (loginResponseModel.value.status ?? false) {
          /// Set login model into shared preference
          MySharedPref().setEmployeeLoginModel(loginResponseModel.value??EmployeeLoginResponseModel(), SharePreData.keySaveLoginModel);
          MySharedPref().setString(SharePreData.keyAccessToken, loginResponseModel.value.accessToken??"");
          MySharedPref().setString(SharePreData.keyUserType, UserTypeEnum.employee.outputVal);
          if((loginResponseModel.value.data?[0].termsAndConditionAccept??"false") == "true"){
            Get.offAll(BottomNavigationView(selectTabPosition: 0));
          }else{
            Get.offAll(TermsAndConditionView());
          }

        } else {
          snackBar(context, loginResponseModel.value.message ?? "");
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

    //
    // printData("onClose", "onClose login controller");
    // Get.delete<LoginController>();
  }
}
