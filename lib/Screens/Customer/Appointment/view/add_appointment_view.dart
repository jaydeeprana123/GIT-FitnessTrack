import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Enums/select_date_enum.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/internet_connection.dart';
import '../../../../utils/password_text_field.dart';
import '../controller/appointment_controller.dart';



class AddAppointmentView extends StatefulWidget {

  String? favouriteId;
   AddAppointmentView({Key? key, this.favouriteId}) : super(key: key);

  @override
  State<AddAppointmentView> createState() => _AddAppointmentViewState();
}

class _AddAppointmentViewState extends State<AddAppointmentView> {

  /// Initialize the controller
  AppointmentController controller = Get.find<AppointmentController>();

  final _status = ["Public", "Private"];

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");


    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await controller.getUserInfo();
      controller.remarksEditingController.value.clear();
      controller.dateEditingController.value.clear();
      controller.timeksEditingController.value.clear();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: color_primary, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,

          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: color_primary,
            title: Text(
             "Book Appointment",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: fontInterRegular),
            ),

          ),

        body: Obx(() =>Container(
          height: double.infinity,
          child: Stack(
            children: [



              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, bottom: 2,top: 24),
                      child: Text("REMARKS", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                    ),


                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(11.r)),
                        border: Border.all(width: 1, color: line_gray_e2e2e6),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context)
                                  .viewInsets
                                  .bottom),

                          controller: controller
                              .remarksEditingController.value,
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
                                fontFamily: fontInterRegular,
                                fontStyle: FontStyle.normal,
                                fontSize: 13),
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          maxLines: 6,
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
                              return 'Enter Comment';
                            }
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, bottom: 2,top: 20),
                      child: Text("SELECT DATE", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                    ),

                    InkWell(
                      onTap: () async {
                        printData("click on", "birth");
                        FocusScope.of(context).unfocus();

                        DateTime? dateTime = await Helper().selectDateInYYYYMMDD(context,
                            SelectDateEnum.Future.outputVal);

                        controller.dateEditingController.value.text = getDateFormtYYYYMMDDOnly(dateTime.toString());

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
                          child:   controller.dateEditingController
                              .value.text.isEmpty?Text("",style: TextStyle(
                              color: hint_txt_909196,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontInterMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 13.sp)):Text(controller.dateEditingController
                              .value.text, style:TextStyle(
                              color: subtitle_black_101623,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontInterMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 13.sp))
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, bottom: 2,top: 20),
                      child: Text("SELECT TIME", style: TextStyle(color: text_color,fontSize: 12, fontFamily: fontInterMedium)),
                    ),
                    InkWell(
                      onTap: () async{

                        TimeOfDay? pickedTime = await  showTimePicker(
                          context: context,
                            initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );




                        //
                        // TimeOfDay? pickedTime =  await showTimePicker(
                        //   initialTime: TimeOfDay.now(),
                        //   context: context, //context of current state
                        // );

                        if(pickedTime != null ){
                          print(pickedTime.format(context, ));   //output 10:51 PM


                          setState(() {


                            var df =  DateFormat("h:mm a");
                            var dt = df.parse(pickedTime.format(context, ));
                            print(DateFormat('HH:mm').format(dt));

                            controller.timeksEditingController.value.text = DateFormat('HH:mm').format(dt);
                          });


                        }else{
                          print("Time is not selected");
                        }
                      },
                      child: Container(width: double.infinity,
                          margin: EdgeInsets.only(left: 24, right: 24),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(11.r)),
                              border: Border.all(
                                  width: 1,
                                  color: line_gray_e2e2e6),
                              color: Colors.white),
                          child:  controller.timeksEditingController.value.text.isEmpty?Text("",style: TextStyle(
                              color: hint_txt_909196,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontInterMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 13.sp)):Text( controller.timeksEditingController
                              .value.text, style:TextStyle(
                              color: subtitle_black_101623,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontInterMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 13.sp))
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 38.0, right: 38, bottom: 30),
                        child: CommonGreenButton("SUBMIT", () {
                          FocusScope.of(context).unfocus();

                          if (controller
                                  .remarksEditingController.value.text.isEmpty) {
                            snackBar(context, "Enter Comment");
                            return;
                          }

                          if (controller
                              .dateEditingController.value.text.isEmpty) {
                            snackBar(context, "Enter Date");
                            return;
                          }

                          if (controller
                              .timeksEditingController.value.text.isEmpty) {
                            snackBar(context, "Enter Time");
                            return;
                          }

                          checkNet(context).then((value) {
                            controller.callBookAppointmentAPI(context);
                          });
                        }, button_Color),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
