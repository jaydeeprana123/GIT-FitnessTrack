import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../CommonWidgets/toolbar_with_title.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import '../controller/customer_login_controller.dart';
import '../controller/employee_login_controller.dart';

class CustomerOtpVerificationView extends StatefulWidget {
  CustomerOtpVerificationView({Key? key}) : super(key: key);

  @override
  State<CustomerOtpVerificationView> createState() => _CustomerOtpVerificationViewState();
}

class _CustomerOtpVerificationViewState extends State<CustomerOtpVerificationView> {
  CustomerLoginController loginController = Get.find<CustomerLoginController>();
  TextEditingController controller = TextEditingController();
  // late OTPTextEditController controller;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // late OTPInteractor _otpInteractor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _firebaseMessaging.getToken().then((token) {
    //   loginController.deviceToken = token;
    //   printData(runtimeType.toString(), token.toString());
    // });
    loginController.otpText.value = TextEditingController();
    // autoFillPin();
  }

  // autoFillPin() {
  //   _otpInteractor = OTPInteractor();
  //   _otpInteractor.getAppSignature()
  //       //ignore: avoid_print
  //       .then((value) {
  //     setState(() {
  //       loginController.otpText.value = TextEditingController(text: value);
  //     });
  //   });
  //
  //   controller = OTPTextEditController(
  //     codeLength: 4,
  //     //ignore: avoid_print
  //     onCodeReceive: (code) => print('Your Application receive code - $code'),
  //     otpInteractor: _otpInteractor,
  //   )..startListenUserConsent(
  //       (code) {
  //         final exp = RegExp(r'(\d{4})');
  //         return exp.stringMatch(code ?? '') ?? '';
  //       },
  //       strategies: [],
  //     );
  // }

  Future<void> dispose() async {
    // if (mounted) {
    //   await controller.stopListen();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: bg_btn_199a8e, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));

    return SafeArea(
        child: AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitle(str_mobile_verification),
            Container(
                margin: EdgeInsets.only(left: 14.w, top: 35.h),
                child: Text(
                  (str_enter_verification_code),
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: fontInterBold,
                      color: title_black_15181e),
                )),
            Container(
                margin: EdgeInsets.only(left: 14.w, top: 5.h),
                child: Text(
                  (str_enter_verification_code_send_your_mobile_no),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: fontInterRegular,
                      color: silver_67696c),
                )),
            Container(
                margin: EdgeInsets.only(left: 14.w, top: 2.h),
                child: Text(
                  // widget.mobileNo,
                  "+91" + loginController.mobileNoEditingController.value.text,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: fontInterMedium,
                      color: bg_btn_199a8e),
                )),
            SizedBox(
              height: 57.7.h,
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 180.w,
                  alignment: Alignment.topCenter,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.black,
                      primaryColorDark: Colors.black,
                      focusColor: Colors.black,
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: Colors.black, //thereby
                      ),
                    ),
                    child: PinCodeTextField(
                      controller: controller,
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      obscuringCharacter: '*',
                      obscuringWidget: null,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      enablePinAutofill: true,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10.r),
                          fieldHeight: 37.6,
                          fieldWidth: 37.6,
                          borderWidth: 1,
                          activeFillColor: bg_gray_f1eadc,
                          inactiveColor: silver_border_e5e7eb,
                          inactiveFillColor: silver_box_f9fafb,
                          errorBorderColor: smoke_f5f5f5,
                          activeColor: smoke_f5f5f5,
                          selectedColor: silver_border_e5e7eb,
                          selectedFillColor: silver_border_e5e7eb),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: Colors.transparent,
                          blurRadius: 2.r,
                        )
                      ],
                      onCompleted: (v) {
                        if (kDebugMode) {
                          setState(() {});
                          if (controller.text.isEmpty) {
                            snackBarRapid(context, "Enter OTP");
                            return;
                          }
                          checkNet(context).then((value) {
                            loginController.callVerifyOtpAPI(
                                context,
                                controller.value.text);
                          });
                        }
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      beforeTextPaste: (text) {
                        if (kDebugMode) {
                          print("Allowing to paste $text");
                        }
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 14.h),
                child: CommonGreenButton(str_verify, () {
                  if (controller.text.isEmpty) {
                    snackBarRapid(context, "Enter OTP");
                    return;
                  }
                  checkNet(context).then((value) {

                    loginController.callVerifyOtpAPI(
                        context,
                        controller.value.text);
                  });
                },
                    controller.value.text.length == 4
                        ? bg_btn_199a8e
                        : line_gray_e2e2e6)),
            GestureDetector(
              onTap: () {
                checkNet(context).then((value) {
                  loginController.callResendSendOTPAPI(context);
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 0.h, bottom: 35.h),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: (str_didn_not_receive_the_code),
                        style: TextStyle(
                            color: silver_67696c,
                            fontSize: 14.sp,
                            fontFamily: fontInterMedium),
                        children: <TextSpan>[
                          TextSpan(
                            text: (str_resend),
                            style: TextStyle(
                                color: bg_btn_199a8e,
                                fontSize: 14.sp,
                                fontFamily: fontInterMedium),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
