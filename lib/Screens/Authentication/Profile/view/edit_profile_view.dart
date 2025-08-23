import 'dart:developer';
import 'package:fitness_track/Screens/Authentication/Profile/model/area_list_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import '../model/city_list_model.dart';
import '../model/state_list_model.dart';



class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  /// Initialize the controller
  ProfileController controller = Get.find<ProfileController>();
  String? strSelectedState;
  String? strSelectedCity;
  String? strSelectedArea;
  @override
  void initState() {
    super.initState();

    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");
    WidgetsBinding.instance.addPostFrameCallback((_) async{
     await controller.getUserInfo();
     await controller.callGetProfileUpAPI();
     await controller.getStateList();

     if(((controller.loginResponseModel.value.data?[0].stateId??"").isNotEmpty) && ((controller.loginResponseModel.value.data?[0].stateId??"") != "0")){
       strSelectedState = controller.loginResponseModel.value.data?[0].stateId;


       printData("state", strSelectedState??"");

       await controller.getCityList( strSelectedState??"");
     }

     if((controller.loginResponseModel.value.data?[0].cityId??"").isNotEmpty && ((controller.loginResponseModel.value.data?[0].cityId??"") != "0")){
       strSelectedCity = controller.loginResponseModel.value.data?[0].cityId;

       await controller.getAreaList(strSelectedCity??"");
     }

     if((controller.loginResponseModel.value.data?[0].areaId??"").isNotEmpty && ((controller.loginResponseModel.value.data?[0].stateId??"") != "0")){
       strSelectedArea = controller.loginResponseModel.value.data?[0].areaId;
     }

     setState(() {

     });

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
                   "Edit Profile",
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                       fontFamily: fontInterMedium),
                 ),
               ),


               // InkWell(
               //   onTap: () {
               //
               //   },
               //   child: SvgPicture.asset(
               //     icon_edit_pen,
               //     width: 22,
               //     height: 22,
               //     color: Colors.white,
               //   ),
               // )


             ],
           ),
         ),
        body: Obx(() =>Stack(
          children: [
            
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  SizedBox(height: 10,),

                  Center(
                    child: InkWell(
                      onTap: () async {

                        controller.imagePathOfProfile.value = await selectPhoto(context, true);

                        printData("controller.imagePath.value",
                            controller.imagePathOfProfile.value);
                        setState(() {});
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(58.r),
                          child:
                          // controller.imagePath.value.isNotEmpty
                          //     ?

                          (controller
                              .imagePathOfProfile.value.isNotEmpty)
                              ? Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )
                              : (controller
                              .loginResponseModel
                              .value.data?[0]
                              .photo ??
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
                                  .photo ??
                                  "",
                              imageBuilder: (context,
                                  imageProvider) {
                                return Container(
                                    height: 116,
                                    width: 116,
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
                                    height: 116,
                                    width: 116,
                                    fit: BoxFit.cover,
                                  ),
                              errorWidget: (context,
                                  url, error) =>
                                  Image.asset(
                                    img_photo_place_holder,
                                    height: 116,
                                    width: 116,
                                    fit: BoxFit.cover,
                                  ),
                            ),
                          )
                              : DottedBorder(
                            dashPattern: [6, 3],
                            strokeWidth: 1.5,
                            color: hint_txt_909196,
                            borderType:
                            BorderType.Circle,
                            radius: Radius.circular(50),
                            child: Container(
                              height: 116,
                              width: 116,
                              decoration:
                              const BoxDecoration(
                                  shape: BoxShape
                                      .circle,
                                  color:
                                  line_gray_e2e2e6),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: [
                                  SvgPicture.asset(
                                      icon_add_plus_square_new, height: 20, width: 20,color: text_color,),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text("Add",
                                      style: TextStyle(
                                          color: const Color(
                                              0xff3e4046),
                                          fontFamily:
                                          fontInterSemiBold,
                                          fontStyle:
                                          FontStyle
                                              .normal,
                                          fontSize:
                                          14),
                                      textAlign:
                                      TextAlign
                                          .left)
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.only( top:10, bottom: 25.h),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                        //       child: Text("EMPLOYEE CODE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                        //     ),
                        //
                        //     Container(
                        //       margin: EdgeInsets.only(left: 24, right: 24),
                        //       decoration: BoxDecoration(
                        //         borderRadius:
                        //         BorderRadius.all(Radius.circular(11.r)),
                        //         border:
                        //         Border.all(width: 0.5, color: text_color),
                        //       ),
                        //       child: Padding(
                        //         padding: EdgeInsets.all(10.r),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Expanded(
                        //               flex: 1,
                        //               child: Theme(
                        //                   data: ThemeData(
                        //                     primaryColor: Colors.green,
                        //                     primaryColorDark: Colors.red,
                        //                   ),
                        //                   child: TextFormField(
                        //                     scrollPadding: EdgeInsets.only(
                        //                         bottom: MediaQuery.of(context).viewInsets.bottom),
                        //                     onChanged: (value) {
                        //
                        //                     },
                        //                     controller: controller
                        //                         .employeeCodeEditingController.value,
                        //                     style: TextStyle(
                        //                         color: text_color,
                        //                         fontWeight: FontWeight.w500,
                        //                         fontFamily: fontInterMedium,
                        //                         fontStyle: FontStyle.normal,
                        //                         fontSize: 13),
                        //                     decoration: InputDecoration(
                        //                       isDense: true,
                        //                       contentPadding: EdgeInsets.zero,
                        //                       hintStyle: TextStyle(
                        //                           color: text_color,
                        //                           fontWeight: FontWeight.w500,
                        //                           fontFamily: fontInterMedium,
                        //                           fontStyle: FontStyle.normal,
                        //                           fontSize: 13),
                        //                       border: InputBorder.none,
                        //                     ),
                        //                     textInputAction: TextInputAction.next,
                        //                     keyboardType: TextInputType.text,
                        //                     cursorColor: text_color,
                        //                     validator: (value) {
                        //                       if (value.toString().isNotEmpty) {
                        //                         return null;
                        //                       } else {
                        //
                        //                         printData("value", value.toString());
                        //                         return 'Enter Employee Code';
                        //                       }
                        //                     },
                        //                   )),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //
                        //
                        //     SizedBox(
                        //       height: 15.h,
                        //     ),
                        //   ],
                        // ),


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


                       // Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("BASIC SALARY", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .basicSalaryEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Enter Country';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                       //  Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("SUNDAY AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .sundayAmountEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Enter Country';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                       // Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("OVER TIME AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .overtimeAmountEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Enter Over Time Amount';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                       // Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("PERSONAL TRAINING AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .personalTrainingAmountEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Personal Training Amount';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                       // Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("ABSENT AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .absentAmountEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Absent Amount';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                       //  Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("LATE MIN AMOUNT", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .lateMinAmountEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Late Min Amount';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),


                        Column(
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
                        ),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 2),
                              child: Text("STATE", style: TextStyle(color: text_color,fontSize: 12.sp, fontFamily: fontInterMedium)),
                            ),
                               Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(color: text_color, width: 0.5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child:

                                DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select State',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _addDividersAfterItems(controller.stateList ?? []),
                                  value: strSelectedState,
                                  onChanged: (String? value) {
                                    setState(() {
                                      strSelectedState = value;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    customHeights: _getCustomItemsHeights(controller.stateList.length),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    openMenuIcon: Icon(Icons.arrow_drop_up),
                                  ),
                                ),




                                // DropdownButton2(
                                //
                                //   isExpanded: true,
                                //   offset: const Offset(0, -3),
                                //
                                //   icon: Container(
                                //     padding: EdgeInsets.only(right: 10.w),
                                //     child: SvgPicture.asset(
                                //       icon_down_arrow,
                                //       color: text_color,
                                //     ),
                                //   ),
                                //   hint: Container(
                                //     padding: EdgeInsets.only( right: 14),
                                //     child: Text(
                                //       'Select State',
                                //       style: TextStyle(
                                //           color: text_color,
                                //           fontFamily: fontInterRegular,
                                //           fontSize: 14),
                                //
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                                //   items: (controller.stateList ?? [])
                                //       .isNotEmpty
                                //       ? (controller.stateList.value ?? [])
                                //       .map((StateData value) =>
                                //       DropdownMenuItem<String>(
                                //         value: value.id.toString(),
                                //
                                //         child: Container(
                                //           padding:
                                //           EdgeInsets.only(right: 14),
                                //           // color: Colors.red,
                                //           decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius:
                                //             BorderRadius.all(Radius.circular(11.r)),
                                //             border: Border.all(width: 0.5, color: Colors.white),
                                //           ),
                                //           child: Text(
                                //             value.name??"",
                                //             style: TextStyle(
                                //               fontSize: 14,
                                //               fontFamily: fontInterMedium,
                                //               color: Colors.black,
                                //             ),
                                //             overflow: TextOverflow.ellipsis,
                                //           ),
                                //         ),
                                //       ))
                                //       .toList()
                                //       : <String>[].map((String value) {
                                //     return const DropdownMenuItem<String>(
                                //       value: "",
                                //       child: SizedBox(),
                                //     );
                                //   }).toList(),
                                //   value: strSelectedState,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       if(strSelectedState != value as String){
                                //         strSelectedState = value;
                                //         strSelectedCity = null;
                                //         strSelectedArea = null;
                                //
                                //         printData("strSelectedState",
                                //             strSelectedState ?? "");
                                //
                                //         controller.getCityList(context, strSelectedState??"");
                                //
                                //
                                //       }
                                //     });
                                //   },
                                //   // buttonHeight: 40,
                                //   // buttonWidth: 140,
                                //   // itemHeight: 40,
                                //   dropdownMaxHeight: 175,
                                //   scrollbarThickness: 3,
                                //   scrollbarAlwaysShow: true,
                                //   // dropdownWidth: double.infinity,
                                // ),
                              ),
                            ),
                          ],
                        ),

                       strSelectedState != null? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 2,top: 16),
                              child: Text("CITY", style: TextStyle(color: text_color,fontSize: 12.sp, fontFamily: fontInterMedium)),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(color: text_color, width: 0.5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child:


                                DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select City',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _addDividersAfterCityItems(controller.cityList ?? []),
                                  value: strSelectedCity,
                                  onChanged: (String? value) {
                                    setState(() {
                                      strSelectedCity = value;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    customHeights: _getCustomItemsHeights(controller.cityList.length),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    openMenuIcon: Icon(Icons.arrow_drop_up),
                                  ),
                                ),




                                // DropdownButton2(
                                //
                                //   isExpanded: true,
                                //   offset: const Offset(0, -3),
                                //
                                //   icon: Container(
                                //     padding: EdgeInsets.only(right: 10.w),
                                //     child: SvgPicture.asset(
                                //       icon_down_arrow,
                                //       color: text_color,
                                //     ),
                                //   ),
                                //   hint: Container(
                                //     padding: EdgeInsets.only( right: 14),
                                //     child: Text(
                                //       'Select City',
                                //       style: TextStyle(
                                //           color: text_color,
                                //           fontFamily: fontInterRegular,
                                //           fontSize: 14),
                                //
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                                //   items: (controller.cityList.value ?? [])
                                //       .isNotEmpty
                                //       ? (controller.cityList.value ?? [])
                                //       .map((CityData value) =>
                                //       DropdownMenuItem<String>(
                                //         value: value.id.toString(),
                                //
                                //         child: Container(
                                //           padding:
                                //           EdgeInsets.only(right: 14),
                                //           // color: Colors.red,
                                //           decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius:
                                //             BorderRadius.all(Radius.circular(11.r)),
                                //             border: Border.all(width: 0.5, color: Colors.white),
                                //           ),
                                //           child: Text(
                                //             value.cityName??"",
                                //             style: TextStyle(
                                //               fontSize: 14,
                                //               fontFamily: fontInterMedium,
                                //               color: Colors.black,
                                //             ),
                                //             overflow: TextOverflow.ellipsis,
                                //           ),
                                //         ),
                                //       ))
                                //       .toList()
                                //       : <String>[].map((String value) {
                                //     return const DropdownMenuItem<String>(
                                //       value: "",
                                //       child: SizedBox(),
                                //     );
                                //   }).toList(),
                                //   value: strSelectedCity,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       if(strSelectedCity != value as String){
                                //         strSelectedCity = value as String;
                                //
                                //         strSelectedArea = null;
                                //
                                //         printData("strSelectedCity",
                                //             strSelectedCity ?? "");
                                //
                                //         controller.getAreaList(context, strSelectedCity??"");
                                //
                                //
                                //       }
                                //     });
                                //   },
                                //   // buttonHeight: 40,
                                //   // buttonWidth: 140,
                                //   // itemHeight: 40,
                                //   dropdownMaxHeight: 175,
                                //   scrollbarThickness: 3,
                                //   scrollbarAlwaysShow: true,
                                //   // dropdownWidth: double.infinity,
                                // ),
                              ),
                            ),
                          ],
                        ):SizedBox(),


                        strSelectedCity != null?  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 2,top: 16),
                              child: Text("AREA", style: TextStyle(color: text_color,fontSize: 12.sp, fontFamily: fontInterMedium)),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 24, right: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(color: text_color, width: 0.5),
                              ),
                              child: DropdownButtonHideUnderline(


                                child:  DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Area',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _addDividersAfterAreaItems(controller.areaList ?? []),
                                  value: strSelectedArea,
                                  onChanged: (String? value) {
                                    setState(() {
                                      strSelectedArea = value;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    customHeights: _getCustomItemsHeights(controller.areaList.length),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    openMenuIcon: Icon(Icons.arrow_drop_up),
                                  ),
                                ),


                                // child: DropdownButton2(
                                //
                                //   isExpanded: true,
                                //   offset: const Offset(0, -3),
                                //
                                //   icon: Container(
                                //     padding: EdgeInsets.only(right: 10.w),
                                //     child: SvgPicture.asset(
                                //       icon_down_arrow,
                                //       color: text_color,
                                //     ),
                                //   ),
                                //   hint: Container(
                                //     padding: EdgeInsets.only( right: 14),
                                //     child: Text(
                                //       'Select Area',
                                //       style: TextStyle(
                                //           color: text_color,
                                //           fontFamily: fontInterRegular,
                                //           fontSize: 14),
                                //
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                                //   items: (controller.areaList.value ?? [])
                                //       .isNotEmpty
                                //       ? (controller.areaList.value ?? [])
                                //       .map((AreaData value) =>
                                //       DropdownMenuItem<String>(
                                //         value: value.id.toString(),
                                //
                                //         child: Container(
                                //           padding:
                                //           EdgeInsets.only(right: 14),
                                //           // color: Colors.red,
                                //           decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius:
                                //             BorderRadius.all(Radius.circular(11.r)),
                                //             border: Border.all(width: 0.5, color: Colors.white),
                                //           ),
                                //           child: Text(
                                //             value.areaName??"",
                                //             style: TextStyle(
                                //               fontSize: 14,
                                //               fontFamily: fontInterMedium,
                                //               color: Colors.black,
                                //             ),
                                //             overflow: TextOverflow.ellipsis,
                                //           ),
                                //         ),
                                //       ))
                                //       .toList()
                                //       : <String>[].map((String value) {
                                //     return const DropdownMenuItem<String>(
                                //       value: "",
                                //       child: SizedBox(),
                                //     );
                                //   }).toList(),
                                //   value: strSelectedArea,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       strSelectedArea = value as String;
                                //
                                //
                                //       printData("strSelectedArea",
                                //           strSelectedArea ?? "");
                                //     });
                                //   },
                                //   // buttonHeight: 40,
                                //   // buttonWidth: 140,
                                //   // itemHeight: 40,
                                //   dropdownMaxHeight: 175,
                                //   scrollbarThickness: 3,
                                //   scrollbarAlwaysShow: true,
                                //   // dropdownWidth: double.infinity,
                                // ),
                              ),
                            ),
                          ],
                        ):SizedBox(),




                       // Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("AREA", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .areaEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Enter Area';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                       //
                       //  Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("CITY", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .cityEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Enter City';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                       //  Column(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Padding(
                       //        padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                       //        child: Text("STATE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                       //      ),
                       //
                       //      Container(
                       //        margin: EdgeInsets.only(left: 24, right: 24),
                       //        decoration: BoxDecoration(
                       //          borderRadius:
                       //          BorderRadius.all(Radius.circular(11.r)),
                       //          border:
                       //          Border.all(width: 0.5, color: text_color),
                       //        ),
                       //        child: Padding(
                       //          padding: EdgeInsets.all(10.r),
                       //          child: Row(
                       //            mainAxisAlignment: MainAxisAlignment.center,
                       //            children: [
                       //              Expanded(
                       //                flex: 1,
                       //                child: Theme(
                       //                    data: ThemeData(
                       //                      primaryColor: Colors.green,
                       //                      primaryColorDark: Colors.red,
                       //                    ),
                       //                    child: TextFormField(
                       //                      scrollPadding: EdgeInsets.only(
                       //                          bottom: MediaQuery.of(context).viewInsets.bottom),
                       //                      onChanged: (value) {
                       //
                       //                      },
                       //                      controller: controller
                       //                          .stateEditingController.value,
                       //                      style: TextStyle(
                       //                          color: text_color,
                       //                          fontWeight: FontWeight.w500,
                       //                          fontFamily: fontInterMedium,
                       //                          fontStyle: FontStyle.normal,
                       //                          fontSize: 13),
                       //                      decoration: InputDecoration(
                       //                        isDense: true,
                       //                        contentPadding: EdgeInsets.zero,
                       //                        hintStyle: TextStyle(
                       //                            color: text_color,
                       //                            fontWeight: FontWeight.w500,
                       //                            fontFamily: fontInterMedium,
                       //                            fontStyle: FontStyle.normal,
                       //                            fontSize: 13),
                       //                        border: InputBorder.none,
                       //                      ),
                       //                      textInputAction: TextInputAction.next,
                       //                      keyboardType: TextInputType.text,
                       //                      cursorColor: text_color,
                       //                      validator: (value) {
                       //                        if (value.toString().isNotEmpty) {
                       //                          return null;
                       //                        } else {
                       //
                       //                          printData("value", value.toString());
                       //                          return 'Enter State';
                       //                        }
                       //                      },
                       //                    )),
                       //              ),
                       //            ],
                       //          ),
                       //        ),
                       //      ),
                       //
                       //
                       //      SizedBox(
                       //        height: 15.h,
                       //      ),
                       //    ],
                       //  ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [



                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 4, top: 15),
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
                        ),




                        Column(
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
                        ),

                        Column(
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
                                child: InkWell(
                                  onTap: () async {

                                    controller.imagePathOfAadharCard.value = await selectPhoto(context, true);

                                    printData("controller.imagePath.value",
                                        controller.imagePathOfAadharCard.value);
                                    setState(() {});
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2.r),
                                      child:
                                      // controller.imagePath.value.isNotEmpty
                                      //     ?

                                      (controller
                                          .imagePathOfAadharCard.value.isNotEmpty)
                                          ? Image.file(
                                        imageFile,
                                        fit: BoxFit.cover,
                                        height: 130,
                                        width: double.infinity,
                                      )
                                          : (controller
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
                                          : DottedBorder(
                                        dashPattern: [6, 3],
                                        strokeWidth: 1.5,
                                        color: hint_txt_909196,
                                        borderType:
                                        BorderType.Rect,
                                        radius: Radius.circular(2),
                                        child: Container(
                                          padding: EdgeInsets.all(30),
                                           height: 130,
                                          width: double.infinity,
                                          decoration:
                                          const BoxDecoration(
                                              shape: BoxShape
                                                  .rectangle,
                                              color:
                                              line_gray_e2e2e6),
                                          child:
                                          SvgPicture.asset(
                                              icon_add_plus_square_new,color: text_color,height: 30,width: 30,)
                                          // Column(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment
                                          //       .center,
                                          //
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //         icon_add_plus_square_new),
                                          //     SizedBox(
                                          //       height: 5.h,
                                          //     ),
                                          //     Text("Add",
                                          //         style: TextStyle(
                                          //             color: const Color(
                                          //                 0xff3e4046),
                                          //             fontFamily:
                                          //             fontInterSemiBold,
                                          //             fontStyle:
                                          //             FontStyle
                                          //                 .normal,
                                          //             fontSize:
                                          //             14),
                                          //         textAlign:
                                          //         TextAlign
                                          //             .left)
                                          //   ],
                                          // ),
                                        ),
                                      )),
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 8, top: 12),
                              child: Text("Bank Details : ", style: TextStyle(color: text_color,fontSize: 14, fontFamily: fontInterSemiBold)),
                            ),


                            Column(
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
                            ),

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
                        ),
                        Column(
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
                        ),
                       Column(
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
                        ),
                        Column(
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


                            // SizedBox(
                            //   height: 15.h,
                            // ),
                          ],
                        ),

                        SizedBox(
                          height: 15.h,
                        ),
                        Column(
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
                                child: InkWell(
                                  onTap: () async {

                                    controller.imagePathOfOldCancelledCheque.value = await selectPhoto(context, true);

                                    printData("controller.imagePathOfOldCancelledCheque.value",
                                        controller.imagePathOfOldCancelledCheque.value);
                                    setState(() {});
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2.r),
                                      child:
                                      // controller.imagePath.value.isNotEmpty
                                      //     ?

                                      (controller
                                          .imagePathOfOldCancelledCheque.value.isNotEmpty)
                                          ? Image.file(
                                        imageFile,
                                        fit: BoxFit.cover,
                                        height: 130,
                                        width: double.infinity,
                                      )
                                          : (controller
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
                                          : DottedBorder(
                                        dashPattern: [6, 3],
                                        strokeWidth: 1.5,
                                        color: hint_txt_909196,
                                        borderType:
                                        BorderType.Rect,
                                        radius: Radius.circular(2),
                                        child: Container(
                                            padding: EdgeInsets.all(30),
                                            height: 130,
                                            width: double.infinity,
                                            decoration:
                                            const BoxDecoration(
                                                shape: BoxShape
                                                    .rectangle,
                                                color:
                                                line_gray_e2e2e6),
                                            child:
                                            SvgPicture.asset(
                                              icon_add_plus_square_new,color: text_color,height: 30,width: 30,)
                                          // Column(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment
                                          //       .center,
                                          //
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //         icon_add_plus_square_new),
                                          //     SizedBox(
                                          //       height: 5.h,
                                          //     ),
                                          //     Text("Add",
                                          //         style: TextStyle(
                                          //             color: const Color(
                                          //                 0xff3e4046),
                                          //             fontFamily:
                                          //             fontInterSemiBold,
                                          //             fontStyle:
                                          //             FontStyle
                                          //                 .normal,
                                          //             fontSize:
                                          //             14),
                                          //         textAlign:
                                          //         TextAlign
                                          //             .left)
                                          //   ],
                                          // ),
                                        ),
                                      )),
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),




                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 38.0, right: 38),
                    child: CommonGreenButton(str_submit, () {
                      FocusScope.of(context).unfocus();

                      if (controller
                          .nameEditingController.value.text.isEmpty) {
                        snackBar(context, "Enter Name");
                        return;
                      }
                      if (controller
                          .emailEditingController.value.text.isEmpty) {
                        snackBar(context, "Enter Email");
                        return;
                      }


                      if (controller
                          .mobileNoEditingController.value.text.isEmpty) {
                        snackBar(context, "Enter mobile number");
                        return;
                      }


                      checkNet(context).then((value) {
                        controller.callEditProfileUpAPI(strSelectedState??"", strSelectedCity??"", strSelectedArea??"");
                      });
                    },
                        button_Color),
                  ),

                  SizedBox(height: 20,)

                ],
              ),
            ),

            if(controller.isLoading.value)Center(child: CircularProgressIndicator(),)
          ],
        ),
      )),
    );
  }


  List<double> _getCustomItemsHeights(int lengthOfArray) {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (lengthOfArray * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<StateData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final StateData item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.name??"",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<DropdownMenuItem<String>> _addDividersAfterCityItems(List<CityData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final CityData item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.cityName??"",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<DropdownMenuItem<String>> _addDividersAfterAreaItems(List<AreaData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final AreaData item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.areaName??"",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

}
