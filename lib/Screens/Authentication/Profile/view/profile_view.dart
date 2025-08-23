import 'dart:developer';
import 'package:fitness_track/Screens/Authentication/Profile/view/edit_profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import '../controller/profile_controller.dart';



class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  /// Initialize the controller
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");
    WidgetsBinding.instance.addPostFrameCallback((_) async{
     await controller.getUserInfo();
     controller.callGetProfileUpAPI();
    });
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
         appBar:  AppBar(
           backgroundColor: color_primary,
           automaticallyImplyLeading: true,
           iconTheme: IconThemeData(
               color: Colors.white //change your color here
           ),
           title: Row(
             children: [
               Expanded(
                 child: Text(
                   "My Profile",
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                       fontFamily: fontInterMedium),
                 ),
               ),


               InkWell(
                 onTap: () {
                   Get.to(EditProfileView())?.then((value) => controller.callGetProfileUpAPI());
                 },
                 child: SvgPicture.asset(
                   icon_edit_pen,
                   width: 22,
                   height: 22,
                   color: Colors.white,
                 ),
               )


             ],
           ),
         ),
        body: Obx(() =>Stack(
          children: [
            (controller
                .loginResponseModel.value.data??[]).isNotEmpty?SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  SizedBox(height: 20,),

                  (controller
                      .loginResponseModel.value.data?[0].photo ??
                      "").isNotEmpty?  Center(
                    child: InkWell(
                      onTap: () async {
                        // controller.imagePath.value =
                        // await selectPhoto(context);
                        // printData("controller.imagePath.value",
                        //     controller.imagePath.value);
                        setState(() {});
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35.r),
                        child:

                        CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: controller
                              .loginResponseModel.value.data?[0].photo ??
                              "",
                          imageBuilder: (context, imageProvider) {
                            return Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ));
                          },
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                              Image.asset(
                                icon_logo,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                icon_logo,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                        ),

                      ),
                    ),
                  ):SizedBox(),


                  Container(
                    padding: EdgeInsets.only( top:10, bottom: 25.h),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        controller.employeeCodeEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("EMPLOYEE CODE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .employeeCodeEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Employee Code';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.designationNameEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("DESIGNATION", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .designationNameEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Designation Name';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),


                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                          child: Text("NAME", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 24, right: 24),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(11.r)),
                            border: Border.all(
                                width: 0.5, color: text_color),
                          ),
                          child: TextFormField(
                            onChanged: (value) {

                            },
                            controller: controller
                                .nameEditingController.value,
                            style: TextStyle(
                                color: text_color,
                                fontWeight: FontWeight.w500,
                                fontFamily: fontInterMedium,
                                fontStyle: FontStyle.normal,
                                fontSize: 13),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintStyle: TextStyle(
                                  color: text_color,
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
                            cursorColor: text_color,
                            validator: (value) {
                              if (value.toString().isNotEmpty) {
                                return null;
                              } else {
                                return 'Enter your first name';
                              }
                            },
                          ),
                        ),

                        SizedBox(height: 15,),


                        controller
                            .emailEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("EMAIL", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border: Border.all(
                                    width: 0.5, color: text_color),
                              ),
                              child: TextFormField(
                                onChanged: (value) {

                                },
                                controller: controller
                                    .emailEditingController.value,
                                style: TextStyle(
                                    color: text_color,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: fontInterMedium,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintStyle: TextStyle(
                                      color: text_color,
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
                                cursorColor: text_color,
                                validator: (value) {
                                  if (value.toString().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Enter your email';
                                  }
                                },
                              ),
                            ),

                            SizedBox(height: 15,),
                          ],
                        ):SizedBox(),


                        controller
                            .mobileNoEditingController.value.text.isNotEmpty? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("MOBILE NO", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border: Border.all(
                                    width: 0.5, color: text_color),
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.length == 9 ||
                                      value.length == 10) {
                                    setState(() {});
                                  }
                                },
                                controller: controller
                                    .mobileNoEditingController.value,
                                style: TextStyle(
                                    color: text_color,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: fontInterMedium,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintStyle: TextStyle(
                                      color: text_color,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: fontInterMedium,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13),
                                  border: InputBorder.none,
                                ),
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                      10),
                                ],
                                keyboardType: TextInputType.number,
                                cursorColor: text_color,
                                validator: (value) {
                                  if (value.toString().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Enter Mobile number';
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ):SizedBox(),


                        controller.basicSalaryEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("BASIC SALARY", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .basicSalaryEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Country';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.sundayAmountEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("SUNDAY AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .sundayAmountEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Country';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.overtimeAmountEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("OVER TIME AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .overtimeAmountEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Over Time Amount';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.personalTrainingAmountEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("PERSONAL TRAINING AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .personalTrainingAmountEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Personal Training Amount';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.absentAmountEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("ABSENT AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .absentAmountEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Absent Amount';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.lateMinAmountEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("LATE MIN AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .lateMinAmountEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Late Min Amount';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),


                        controller.addressEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("ADDRESS", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .addressEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Address';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),

                        controller.areaEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("AREA", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .areaEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Area';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),

                        controller.cityEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("CITY", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .cityEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter City';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.stateEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("STATE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .stateEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter State';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.pinCodeEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("PINCODE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .pinCodeEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Pincode';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),


                        (controller
                            .loginResponseModel
                            .value.data?[0]
                            .aadharCardNo ??
                            "")
                            .isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("AADHAR CARD NO", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .aadharCardNoEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Aadhar Card Number';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),


                        (controller
                            .loginResponseModel
                            .value.data?[0]
                            .aadharCardPic ??
                            "")
                            .isNotEmpty? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("AADHAR CARD PHOTO", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              height: 130,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 24, right: 24, top: 4),
                              child: Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2.r),
                                    child:
                                    // controller.imagePath.value.isNotEmpty
                                    //     ?

                                    (controller
                                        .loginResponseModel
                                        .value.data?[0]
                                        .aadharCardPic ??
                                        "")
                                        .isNotEmpty
                                        ? ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(
                                          35.r),
                                      child: CachedNetworkImage(
                                        key: UniqueKey(),
                                        imageUrl: controller
                                            .loginResponseModel
                                            .value.data?[0]
                                            .aadharCardPic ??
                                            "",
                                        imageBuilder: (context,
                                            imageProvider) {
                                          return Container(
                                              height: 130,
                                              width: double.infinity,
                                              decoration:
                                              BoxDecoration(
                                                shape: BoxShape
                                                    .rectangle,
                                                image:
                                                DecorationImage(
                                                  image:
                                                  imageProvider,
                                                  fit: BoxFit
                                                      .cover,
                                                ),
                                              ));
                                        },
                                        progressIndicatorBuilder:
                                            (context, url,
                                            downloadProgress) =>
                                            Image.asset(
                                              img_photo_place_holder,
                                              height: 130,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                        errorWidget: (context,
                                            url, error) =>
                                            Image.asset(
                                              img_photo_place_holder,
                                              height: 130,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                      ),
                                    )
                                        : SizedBox())
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),






                        controller.bankAccountNumberEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("BANK ACCOUNT NO", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .bankAccountNumberEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Bank Account Number';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.bankNameEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("BANK NAME", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .bankNameEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Bank Name';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.ifscCodeEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("IFSC CODE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .ifscCodeEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Ifsc Code';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.accountTypeEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("ACCOUNT TYPE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .accountTypeEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter Account Type';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),
                        controller.upiIdEditingController.value.text.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("UPI ID", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                                border:
                                Border.all(width: 0.5, color: text_color),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.green,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            onChanged: (value) {

                                            },
                                            controller: controller
                                                .upiIdEditingController.value,
                                            style: TextStyle(
                                                color: text_color,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: fontInterMedium,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              hintStyle: TextStyle(
                                                  color: text_color,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: fontInterMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              border: InputBorder.none,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            cursorColor: text_color,
                                            validator: (value) {
                                              if (value.toString().isNotEmpty) {
                                                return null;
                                              } else {

                                                printData("value", value.toString());
                                                return 'Enter UPI Id';
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),

                        (controller
                            .loginResponseModel
                            .value.data?[0]
                            .oldCancelledCheqPhoto ??
                            "")
                            .isNotEmpty? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: Text("CANCELLED CHEQUE PHOTO", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            Container(
                              height: 130,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 24, right: 24, top: 4),
                              child: Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2.r),
                                      child:
                                      // controller.imagePath.value.isNotEmpty
                                      //     ?

                                      (controller
                                          .loginResponseModel
                                          .value.data?[0]
                                          .oldCancelledCheqPhoto ??
                                          "")
                                          .isNotEmpty
                                          ? ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(
                                            35.r),
                                        child: CachedNetworkImage(
                                          key: UniqueKey(),
                                          imageUrl: controller
                                              .loginResponseModel
                                              .value.data?[0]
                                              .oldCancelledCheqPhoto ??
                                              "",
                                          imageBuilder: (context,
                                              imageProvider) {
                                            return Container(
                                                height: 130,
                                                width: double.infinity,
                                                decoration:
                                                BoxDecoration(
                                                  shape: BoxShape
                                                      .rectangle,
                                                  image:
                                                  DecorationImage(
                                                    image:
                                                    imageProvider,
                                                    fit: BoxFit
                                                        .cover,
                                                  ),
                                                ));
                                          },
                                          progressIndicatorBuilder:
                                              (context, url,
                                              downloadProgress) =>
                                              Image.asset(
                                                img_photo_place_holder,
                                                height: 130,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                          errorWidget: (context,
                                              url, error) =>
                                              Image.asset(
                                                img_photo_place_holder,
                                                height: 130,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                        ),
                                      )
                                          : SizedBox())
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ):SizedBox(),

                      ],
                    ),
                  ),
                ],
              ),
            ):SizedBox(),
              if(controller.isLoading.value)Center(child: CircularProgressIndicator(),)
          ],
        ),
      )),
    );
  }
}
