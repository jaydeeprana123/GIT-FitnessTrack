import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_font.dart';
import '../controller/cms_controller.dart';
import 'package:flutter_html/flutter_html.dart';


class OtherPageView extends StatefulWidget {

  String pageName;

  OtherPageView({Key? key, required this.pageName}) : super(key: key);

  @override
  State<OtherPageView> createState() => _OtherPageViewState();
}

class _OtherPageViewState extends State<OtherPageView> {
  CMSController cmsController = Get.put(CMSController());

  @override
  void initState() {
    super.initState();

    cmsController.getCMSPageAPI(context, widget.pageName);
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() =>SafeArea(
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: color_primary,
            title: Text(
              widget.pageName.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: fontInterRegular),
            ),

          ),

          /// Here with obx you can get live data
          body:  SingleChildScrollView(
            child:

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Html(
                  data: (cmsController.aboutUsData.value.description??"")
                      .replaceAll(
                    "justify;",
                    "justify; font-size:12px;color:#68686a;",
                  )),
            )

            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child:  Text(
            //     cmsController.aboutUsData.value.description??"",
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 15,
            //         fontFamily: fontInterRegular),
            //   ),
            // ),
          )),
    ),
    );
  }


}