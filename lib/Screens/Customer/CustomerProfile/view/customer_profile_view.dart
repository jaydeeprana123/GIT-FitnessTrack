import 'dart:developer';
import 'package:fitness_track/Screens/Authentication/Profile/view/edit_profile_view.dart';
import 'package:fitness_track/Screens/Customer/CustomerProfile/view/customer_edit_profile_view.dart';
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
import '../controller/customer_profile_controller.dart';




class CustomerProfileView extends StatefulWidget {
  const CustomerProfileView({Key? key}) : super(key: key);

  @override
  State<CustomerProfileView> createState() => _CustomerProfileViewState();
}

class _CustomerProfileViewState extends State<CustomerProfileView> {

  /// Initialize the controller
  CustomerProfileController controller = Get.put(CustomerProfileController());

  @override
  void initState() {
    super.initState();

    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await controller.getUserInfo();
      controller.callGetProfileUpAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: text_color, // navigation bar color
      statusBarColor: color_primary, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:
      Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
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
                    Get.to(CustomerEditProfileView())?.then((value) => controller.callGetProfileUpAPI(context));
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
                  .loginResponseModel.value.data??[]).isNotEmpty? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    SizedBox(height: 10,),

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


                          controller.clientCodeEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("CLIENT CODE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .clientCodeEditingController.value,
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


                         if(controller
                             .emailEditingController.value.text.isNotEmpty) Column(
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
                          ),


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

                          controller.ageEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("AGE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .ageEditingController.value,
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
                                                  return 'Enter Age';
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
                          controller.genderEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("GENDER", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .genderEditingController.value,
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
                                                  return 'Enter Gender';
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


                          if(controller
                              .programmeNameController.value.text.isNotEmpty) Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("PROGRAMME NAME", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                      .programmeNameController.value,
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
                          ),




                          controller.dobEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("DATE OF BIRTH", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .dobEditingController.value,
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
                                                  return 'Enter Date of Birth';
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

                          controller.occupationEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("OCCUPATION", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .occupationEditingController.value,
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
                                                  return 'Enter Occupation';
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
                          controller.emergencyPersonNameEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("EMERGENCY PERSON NAME", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .emergencyPersonNameEditingController.value,
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
                                                  return 'Enter Emergency Person Name';
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
                          controller.emergencyPersonPhoneEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("EMERGENCY CONTACT NO", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .emergencyPersonPhoneEditingController.value,
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
                                                  return 'Enter Emergency Contact No';
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
                          controller.problemEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("PROBLEM", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .problemEditingController.value,
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
                                                  return 'Enter Problem';
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
                          controller.medicineEditingController.value.text.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("MEDICINE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .medicineEditingController.value,
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
                                                  return 'Enter Medicine';
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

                        ],
                      ),
                    ),
                  ],
                ),
              ):Center(child: CircularProgressIndicator(),),
            ],
          ),
          )),
    );
  }
}
