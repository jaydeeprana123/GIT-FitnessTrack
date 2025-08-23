import 'dart:async';

import 'package:fitness_track/CommonWidgets/common_white_button.dart';
import 'package:fitness_track/Screens/Authentication/Login/view/employee_login_via_otp_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_icons.dart';
import '../../Login/view/customer_login_via_otp_view.dart';



class WelcomeScreenView extends StatefulWidget {
  const WelcomeScreenView({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenView> createState() => _WelcomeScreenViewState();
}

class _WelcomeScreenViewState extends State<WelcomeScreenView> with TickerProviderStateMixin{



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {

    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body:

        Container(
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Image.asset(
                img_splash,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),


              // Container(
              //   height: double.infinity,
              //   color: quater_transparent,
              // ),
              //
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 140),
              //     child: Image.asset(
              //       icon_logo,
              //       width: 250,
              //     ),
              //   ),
              // ),


              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [



                    Padding(
                      padding: const EdgeInsets.only(left: 78.0, right: 78),
                      child: Text("Are You ? ", style: TextStyle(color: Colors.white),)
                    ),

                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 78.0, right: 78),
                      child: CommonWhiteButton("EMPLOYEE", () {

                        Get.to(EmployeeLoginViaOTPView());
                      }, Colors.white),
                    ),

                    SizedBox(height: 12,),


                    Padding(
                      padding: const EdgeInsets.only(left: 78.0, right: 78),
                      child: CommonWhiteButton("MEMBER", () {

                        Get.to(CustomerLoginViaOTPView());
                      }, Colors.white),
                    ),

                    SizedBox(height: 36,),
                  ],
                ),
              )


            ],
          ),
        ),

        // Stack(
        //   children: [
        //     Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Image.asset(
        //             icon_logo,
        //             width: 150,
        //           ),
        //           const SizedBox(
        //             height: 30,
        //           ),
        //           Text(
        //             str_mine_astro,
        //             style: const TextStyle(
        //               fontSize: 28,
        //               color: text_color,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // )
      ),
    );
  }

}
