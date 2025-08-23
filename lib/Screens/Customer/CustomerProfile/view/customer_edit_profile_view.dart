import 'dart:developer';
import 'package:fitness_track/Screens/Authentication/Profile/model/area_list_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Enums/select_date_enum.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/internet_connection.dart';
import '../../../Authentication/Profile/model/city_list_model.dart';
import '../../../Authentication/Profile/model/state_list_model.dart';
import '../controller/customer_profile_controller.dart';


class CustomerEditProfileView extends StatefulWidget {
  const CustomerEditProfileView({Key? key}) : super(key: key);

  @override
  State<CustomerEditProfileView> createState() => _CustomerEditProfileViewState();
}

class _CustomerEditProfileViewState extends State<CustomerEditProfileView> {

  /// Initialize the controller
  CustomerProfileController controller = Get.find<CustomerProfileController>();
  String? strSelectedState;
  String? strSelectedCity;
  String? strSelectedArea;
  @override
  void initState() {
    super.initState();

    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await controller.getUserInfo();
      await controller.callGetProfileUpAPI(context);
      await controller.getStateList(context);

      if(((controller.loginResponseModel.value.data?[0].stateId??"").isNotEmpty) && ((controller.loginResponseModel.value.data?[0].stateId??"") != "0")){
        strSelectedState = controller.loginResponseModel.value.data?[0].stateId;


        printData("state", strSelectedState??"");

        await controller.getCityList(context, strSelectedState??"");
      }

      if((controller.loginResponseModel.value.data?[0].cityId??"").isNotEmpty && ((controller.loginResponseModel.value.data?[0].cityId??"") != "0")){
        strSelectedCity = controller.loginResponseModel.value.data?[0].cityId;

        await controller.getAreaList(context, strSelectedCity??"");
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


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("USERNAME", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
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
                                                  .userNameEditingController.value,
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
                                                  return 'Enter User Name';
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

                          Column(
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
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0, bottom: 4),
                                child: Text("GENDER", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 110,
                                      child: RadioButton(
                                        description: "Male",
                                        value: "Male",
                                        groupValue: controller.male.value == 0
                                            ? "Male"
                                            : "Female",
                                        onChanged: (value) => setState(() {
                                          controller.male.value = 0;
                                          printData("Male", "0");
                                        }),
                                        fillColor: controller.male.value == 0
                                            ? button_Color
                                            : text_color,
                                        activeColor: color_primary,
                                        // Change this line to set active color
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: fontInterRegular,
                                          color: text_color,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: RadioButton(
                                        description: "Female",
                                        value: "Female",
                                        groupValue: controller.male.value == 1
                                            ? "Female"
                                            : "Male",
                                        onChanged: (value) => setState(() {
                                          controller.male.value = 1;
                                          printData("Female",
                                              controller.male.value.toString());
                                        }),
                                        fillColor: controller.male.value == 1
                                            ? button_Color
                                            : text_color,
                                        activeColor: color_primary,
                                        // Change this line to set active color
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: fontInterRegular,
                                          color: text_color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),

                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0, bottom: 2,top: 20),
                              child: Text("DATE OF BIRTH", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                            ),

                            InkWell(
                              onTap: () async {
                                printData("click on", "birth");
                                FocusScope.of(context).unfocus();

                                DateTime? dateTime = await Helper().selectDateInYYYYMMDD(context,
                                    SelectDateEnum.Past.outputVal);

                                controller.dobEditingController.value.text = getDateFormtYYYYMMDDOnly(dateTime.toString());

                                setState(() {

                                });

                              },
                              child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 24, right: 24),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.r)),
                                      border: Border.all(
                                          width: 1,
                                          color: line_gray_e2e2e6),
                                      color: Colors.white),
                                  child:   controller.dobEditingController
                                      .value.text.isEmpty?Text("",style: TextStyle(
                                      color: hint_txt_909196,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: fontInterMedium,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.sp)):Text(controller.dobEditingController
                                      .value.text, style:TextStyle(
                                      color: subtitle_black_101623,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: fontInterMedium,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.sp))
                              ),
                            ),
                          ],),

                          Column(
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
                          ),
                          Column(
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
                          ),
                          Column(
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
                          ),
                          Column(
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
                          ),
                          Column(
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
                          ),



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
                                  //     DropdownButton2(
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
                                  //     DropdownButton2(
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
                                  child:
                                  DropdownButton2<String>(
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
                                      customHeights: _getCustomItemsHeights(controller.cityList.length),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      openMenuIcon: Icon(Icons.arrow_drop_up),
                                    ),
                                  ),
                                  //     DropdownButton2(
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
                          controller.callEditProfileUpAPI(context, strSelectedState??"", strSelectedCity??"", strSelectedArea??"");
                        });
                      },
                          button_Color),
                    ),

                    SizedBox(height: 20,)

                  ],
                ),
              ),
            ],
          ),
          )),
    );
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
}
