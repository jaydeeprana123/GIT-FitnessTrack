import 'dart:developer';

import 'package:fitness_track/CommonWidgets/common_white_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import '../../../../utils/password_text_field.dart';
import '../controller/employee_login_controller.dart';

class EmployeeLoginViaOTPView extends StatefulWidget {
  const EmployeeLoginViaOTPView({Key? key}) : super(key: key);

  @override
  State<EmployeeLoginViaOTPView> createState() => _EmployeeLoginViaOTPViewState();
}

class _EmployeeLoginViaOTPViewState extends State<EmployeeLoginViaOTPView> {
  /// Initialize the controller
  EmployeeLoginController controller = Get.put(EmployeeLoginController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: color_primary, // navigation bar color
      statusBarColor: color_primary, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:
      Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Image.asset(
              img_splash,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [



                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 12),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontFamily: fontInterSemiBold),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(left: 14.w, right: 14.w),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(11.r)),
                        border:
                        Border.all(width: 0.5, color: text_color),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: TextFormField(
                        scrollPadding: EdgeInsets.only(bottom: 30),
                        onChanged: (value) {
                          if (value.length == 9 ||
                              value.length == 10) {
                            setState(() {});
                          }
                        },
                        controller: controller
                            .mobileNoEditingController.value,
                        style: TextStyle(
                            color: subtitle_black_101623,
                            fontWeight: FontWeight.w500,
                            fontFamily: fontInterMedium,
                            fontStyle: FontStyle.normal,
                            fontSize: 15.sp),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText:
                          (str_enter_your_mobile_number),
                          hintStyle: TextStyle(
                              color: hint_txt_909196,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontInterRegular,
                              fontStyle: FontStyle.normal,
                              fontSize: 15.sp),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.numberWithOptions(signed:true, decimal: true),
                        cursorColor: subtitle_black_101623,
                        validator: (value) {
                          if (value.toString().isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter Mobile number';
                          }
                        },
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 22.0, right: 22),
                    child: CommonWhiteButton("Send OTP", () {
                      FocusScope.of(context).unfocus();

                      if (controller
                              .mobileNoEditingController.value.text.length <
                          10) {
                        snackBar(context, "Enter valid number");
                        return;
                      }

                      checkNet(context).then((value) {
                        controller.callSendOTPAPI();
                      });
                    },
                        controller.mobileNoEditingController.value.text
                                    .length ==
                                10
                            ? Colors.white
                            : Colors.white),
                  ),

                  SizedBox(
                    height: 28.h,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(SignUpView());
                  //   },
                  //   child: Center(
                  //     child: RichText(
                  //         text: TextSpan(children: [
                  //       TextSpan(
                  //           style: TextStyle(
                  //               color: black_4d5764,
                  //               fontWeight: FontWeight.w500,
                  //               fontFamily: fontInterMedium,
                  //               fontStyle: FontStyle.normal,
                  //               fontSize: 14.sp),
                  //           text: "Didn't login? "),
                  //       TextSpan(
                  //           style: TextStyle(
                  //             color: bg_btn_199a8e,
                  //             fontWeight: FontWeight.w500,
                  //             fontFamily: fontInterMedium,
                  //             fontStyle: FontStyle.normal,
                  //             fontSize: 14.sp,
                  //           ),
                  //           text: "Sign Up ")
                  //     ])),
                  //   ),
                  // ),
                ],
              ),
            ),


            if(controller.isLoading.value)Center(child: CircularProgressIndicator(),)
          ],
        ),
      ),
    );
  }
}
