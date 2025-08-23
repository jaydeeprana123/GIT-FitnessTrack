import 'dart:convert';

import 'package:fitness_track/Screens/Authentication/Login/view/terms_condition_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Enums/user_type_enum.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../BottomNavigation/view/bottom_navigation_view.dart';
import '../../../Customer/CustomerBottomNavigation/view/customer_bottom_navigation_view.dart';
import '../model/customer_login_response_model.dart';
import '../model/employee_login_response_model.dart';
import '../view/customer_otp_verification_view.dart';
import '../view/employee_otp_verification_view.dart';

/// Controller
class CustomerLoginController extends GetxController {
  /// Editing controller for text field
  Rx<TextEditingController> mobileNoEditingController =
      TextEditingController().obs;
  CustomerLoginResponseModel? loginResponseModel;

  RxBool isPolicyAccepted = false.obs;
  String? deviceToken;
  Rx<TextEditingController> otpText = TextEditingController().obs;



  /// Send OTP api call
  callSendOTPAPI(BuildContext context) async {
     onLoading(context, "Loading..");

    String url = urlBase + urlSendOtpCustomer;

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

    http.StreamedResponse response = await request.send();
     Navigator.pop(context);
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "Login API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status??false) {
          Get.to(CustomerOtpVerificationView());
        } else {
          snackBar(context, baseModel.message ?? "");
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// ReSend OTP api call
  callResendSendOTPAPI(BuildContext context) async {
     onLoading(context, "Loading..");

    String url = urlBase + urlSendOtpCustomer;

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

    http.StreamedResponse response = await request.send();
     Navigator.pop(context);
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "Login API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status ?? false) {

        } else {
          snackBar(context, baseModel.message ?? "");
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// call OTP verify api call
  callVerifyOtpAPI(BuildContext context, String otpTxtFill) async {
     onLoading(context, "Loading..");

    String url = urlBase + urlSendOtpCustomer;

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

    http.StreamedResponse response = await request.send();
     Navigator.pop(context);
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "Login API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
         loginResponseModel = CustomerLoginResponseModel.fromJson(userModel);

        if (loginResponseModel?.status ?? false) {
          /// Set login model into shared preference
          MySharedPref().setString(SharePreData.keyUserType, UserTypeEnum.member.outputVal);
          MySharedPref().setCustomerLoginModel(loginResponseModel??CustomerLoginResponseModel(), SharePreData.keySaveLoginModel);
          MySharedPref().setString(SharePreData.keyAccessToken, loginResponseModel?.accessToken??"");
          Get.offAll(CustomerBottomNavigationView(selectTabPosition: 0));

        } else {
          snackBar(context, loginResponseModel?.message ?? "");
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
