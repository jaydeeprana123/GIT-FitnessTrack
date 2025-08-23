import 'dart:developer';
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
import '../controller/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  /// Initialize the controller
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

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
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Color(0xff095A53), // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Form(
          child: Container(
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  child: Image.asset(
                    width: double.infinity,
                    height: double.infinity,
                    img_bg,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  height: double.infinity,
                  color: half_transparent,
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Center(
                        child: Image.asset(
                          icon_logo,
                          fit: BoxFit.cover,
                          width: 250,
                        ),
                      ),

                      SizedBox(height: 70,),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 24),
                          child: Text(
                            "FORGOT PASSWORD",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                 fontFamily: fontInterSemiBold),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                        child: Text("EMAIL OR USERNAME", style: TextStyle(color: Colors.white,fontSize: 12, fontFamily: fontInterMedium)),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 24, right: 24),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(11.r)),
                          border: Border.all(width: 0.5, color: Colors.white),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: TextFormField(
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context)
                                    .viewInsets
                                    .bottom),

                            controller: controller
                                .emailEditingController.value,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: fontInterMedium,
                                fontStyle: FontStyle.normal,
                                fontSize: 13),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: fontInterRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13),
                              border: InputBorder.none,
                            ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            // keyboardType:
                            //     TextInputType.numberWithOptions(
                            //         signed: true, decimal: true),
                            // inputFormatters: <TextInputFormatter>[
                            //   FilteringTextInputFormatter.digitsOnly,
                            //   LengthLimitingTextInputFormatter(10),
                            // ],
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value.toString().isNotEmpty) {
                                return null;
                              } else {
                                printData("value", value.toString());
                                return 'Enter Username';
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 48.0, right: 48),
                          child: CommonGreenButton("SUBMIT", () {
                            FocusScope.of(context).unfocus();

                            if (controller
                                .emailEditingController.value.text.isEmpty) {
                              snackBar(context, "Enter email id");
                              return;
                            }

                            checkNet(context).then((value) {
                              controller.callForgotPasswordAPI(context);
                            });
                          }, button_Color),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
