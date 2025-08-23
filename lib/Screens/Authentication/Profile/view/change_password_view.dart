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
import '../controller/profile_controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  /// Initialize the controller
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await controller.getUserInfo();
    });
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
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: color_primary,
          title: Text("RESET PASSWORD",style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: fontInterRegular),),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: color_primary,
        resizeToAvoidBottomInset: true,
        body: Form(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.r),
                              topLeft: Radius.circular(30.r))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                            child: Text("OLD PASSWORD", style: TextStyle(color: Colors.white,fontSize: 12, fontFamily: fontInterMedium)),
                          ),
                          
                          Container(
                            margin: EdgeInsets.only(left: 24, right: 24),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11.r)),
                                border: Border.all(
                                    width: 1, color: Colors.white),
                              ),
                            child: TextFormField(
                              onChanged: (value) {},
                              controller:
                                  controller.oldPasswordEditingController.value,
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
                                    color: hint_txt_909196,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: fontInterMedium,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13),
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.done,
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter
                              //       .digitsOnly,
                              //   LengthLimitingTextInputFormatter(
                              //       10),
                              // ],
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value.toString().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Enter your old password';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                            child: Text("NEW PASSWORD", style: TextStyle(color: Colors.white,fontSize: 12, fontFamily: fontInterMedium)),
                          ),
                          
                          Container(
                            margin: EdgeInsets.only(left: 24, right: 24),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border: Border.all(
                                    width: 1, color: Colors.white),
                                ),
                            child: TextFormField(
                              onChanged: (value) {},
                              controller:
                              controller.newPasswordEditingController.value,
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
                                    color: hint_txt_909196,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: fontInterMedium,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13),
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.done,
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter
                              //       .digitsOnly,
                              //   LengthLimitingTextInputFormatter(
                              //       10),
                              // ],
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value.toString().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Enter your New password';
                                }
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                            child: Text("CONFIRM PASSWORD", style: TextStyle(color: Colors.white,fontSize: 12, fontFamily: fontInterMedium)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24, right: 24),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border: Border.all(
                                    width: 1, color: Colors.white),
                            ),
                            child: TextFormField(
                              onChanged: (value) {},
                              controller:
                              controller.confirmPasswordEditingController.value,
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
                                    color: hint_txt_909196,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: fontInterMedium,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13),
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.done,
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter
                              //       .digitsOnly,
                              //   LengthLimitingTextInputFormatter(
                              //       10),
                              // ],
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value.toString().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Enter Confirm password';
                                }
                              },
                            ),
                          ),

                          SizedBox(
                            height: 40.h,
                          ),


                          Padding(
                            padding: const EdgeInsets.only(left: 38.0, right: 38),
                            child: CommonGreenButton(str_submit, () {
                              FocusScope.of(context).unfocus();

                              if (controller
                                  .oldPasswordEditingController.value.text.isEmpty) {
                                snackBar(context, "Enter old password");
                                return;
                              }
                              if (controller
                                  .newPasswordEditingController.value.text.isEmpty) {
                                snackBar(context, "Enter new password");
                                return;
                              }


                              if (controller
                                  .confirmPasswordEditingController.value.text.isEmpty) {
                                snackBar(context, "Enter confirm password");
                                return;
                              }


                              checkNet(context).then((value) {
                                controller.callChangePasswordAPI(context);
                              });
                            },
                                button_Color),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
