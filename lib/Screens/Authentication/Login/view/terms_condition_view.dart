import 'dart:async';
import 'package:fitness_track/Screens/Authentication/Login/controller/employee_login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import 'package:flutter_html/flutter_html.dart';


class TermsAndConditionView extends StatefulWidget {

  TermsAndConditionView({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionView> createState() => _TermsAndConditionViewState();
}

class _TermsAndConditionViewState extends State<TermsAndConditionView> {
  EmployeeLoginController controller = Get.find<EmployeeLoginController>();
  bool isChecked = false;
  @override
  void initState() {
    super.initState();

    controller.getUserInfo();
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
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: color_primary,
            title: Text(
              "Terms & Conditions",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: fontInterRegular),
            ),

          ),

          /// Here with obx you can get live data
          body:  Obx(() =>(controller
              .loginResponseModel
              .value
              .data??[]).isNotEmpty?SingleChildScrollView(
            child:

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Html(
                      data: (controller.loginResponseModel.value.data?[0].termCondition??"")
                          .replaceAll(
                        "justify;",
                        "justify; font-size:12px;color:#68686a;",
                      )),
                ),


                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24, bottom: 0, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                          MaterialStateProperty.resolveWith(
                              getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "I agree the terms & conditions ",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 12,
                            fontFamily: fontInterRegular),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 38.0, right: 38, top: 16),
                  child: CommonGreenButton(str_submit, () {
                    FocusScope.of(context).unfocus();

                    if (!isChecked) {
                      snackBar(context, "Please accept the terms and condition");
                      return;
                    }

                    checkNet(context).then((value) {
                      controller.callSubmitTermsAndConditionDoneAPI(context);
                    });
                  },
                      button_Color),
                ),

                SizedBox(height: 20,)


              ],
            )
          ):Center(child: CircularProgressIndicator(),))),
    )
    ;
  }


  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return button_Color;
    }
    return button_Color;
  }

}