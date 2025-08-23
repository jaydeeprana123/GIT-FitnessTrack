import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidgets/common_green_button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../../CommonWidgets/common_widget.dart';
import '../../../Enums/select_date_enum.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_font.dart';
import '../../../Styles/my_icons.dart';
import 'package:get/get.dart';
import '../../../utils/helper.dart';
import '../../../utils/share_predata.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controller/late_employee_controller.dart';


class LateEmployeeListView extends StatefulWidget {

  LateEmployeeListView({Key? key})
      : super(key: key);

  @override
  _LateEmployeeListViewState createState() => _LateEmployeeListViewState();
}

class _LateEmployeeListViewState extends State<LateEmployeeListView> {
  LateEmployeeController lateEmployeeController = Get.put(LateEmployeeController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      lateEmployeeController.fromDateEditingController.value.clear();
      lateEmployeeController.toDateEditingController.value.clear();

      await lateEmployeeController.getUserInfo();
      lateEmployeeController.getLateEmployeeListAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    "Late Employees",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: fontInterSemiBold),
                  ),
                ),
                Visibility(
                  visible: lateEmployeeController
                          .fromDateEditingController.value.text.isNotEmpty ||
                      lateEmployeeController
                          .toDateEditingController.value.text.isNotEmpty,
                  child: InkWell(
                    onTap: () async {
                      lateEmployeeController.fromDateEditingController.value.clear();
                      lateEmployeeController.toDateEditingController.value.clear();

                      lateEmployeeController.getLateEmployeeListAPI();

                      setState(() {});
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          icon_remove_date,
                          width: 18,
                          height: 18,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Text(" CLEAR DATE",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: fontInterRegular)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: color_primary,
          ),

          /// Here with obx you can get live data
          body: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              DateTime? dateTime = await Helper()
                                  .selectDateInYYYYMMDD(
                                      context, SelectDateEnum.all.outputVal);

                              setState(() {
                                lateEmployeeController.fromDateEditingController.value.text =
                                    getDateFormtYYYYMMDDOnly((dateTime ?? DateTime(2023))
                                        .toString());
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  )),
                              child: Text(lateEmployeeController
                                      .fromDateEditingController.value.text.isNotEmpty
                                  ? lateEmployeeController
                                      .fromDateEditingController.value.text
                                  : "From",
                                  style: TextStyle(color: text_color,
                                      fontSize: 14,  fontFamily: fontInterSemiBold)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              DateTime? dateTime = await Helper()
                                  .selectDateInYYYYMMDD(
                                      context, SelectDateEnum.all.outputVal);

                              setState(() {
                                lateEmployeeController
                                        .toDateEditingController.value.text =
                                    getDateFormtYYYYMMDDOnly((dateTime ?? DateTime(2023))
                                        .toString());
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  )),
                              child: Text(lateEmployeeController
                                      .toDateEditingController.value.text.isNotEmpty
                                  ? lateEmployeeController
                                      .toDateEditingController.value.text
                                  : "To",
                                  style: TextStyle(color: text_color,
                                      fontSize: 14,  fontFamily: fontInterSemiBold)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            lateEmployeeController
                                .getLateEmployeeListByDateAPI();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 4, bottom: 4),
                            margin: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: color_primary,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey,
                                )),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  !lateEmployeeController.isLoading.value
                      ? (lateEmployeeController.lateEmployeeList.isNotEmpty)
                          ? Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                primary: true,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 50),
                                itemCount:
                                lateEmployeeController.lateEmployeeList.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: (){
                                    },
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    width: double.infinity,
                                    // padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.only(
                                        top: 6, bottom: 6, left: 12, right: 12),

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.r),
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey,
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // Text(
                                            //   "EMPLOYEE :  ",
                                            //   style: TextStyle(
                                            //       fontSize: 14,
                                            //       color: text_color,
                                            //       fontFamily: fontInterSemiBold),
                                            // ),
                                            Text(
                                              lateEmployeeController.lateEmployeeList[index].empName??"",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: color_primary,
                                                  fontFamily: fontInterSemiBold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              "BRANCH :  ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: text_color,
                                                  fontFamily: fontInterSemiBold),
                                            ),
                                            Text(
                                              lateEmployeeController.lateEmployeeList[index].branchName??"",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: text_color,
                                                  fontFamily: fontInterRegular),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),


                                        Row(
                                          children: [
                                            Text(
                                              "SHIFT :  ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: text_color,
                                                  fontFamily: fontInterSemiBold),
                                            ),
                                            Text(
                                              lateEmployeeController.lateEmployeeList[index].shiftName??"",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: text_color,
                                                  fontFamily: fontInterRegular),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),



                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(35.r),
                                              child:

                                              CachedNetworkImage(
                                                key: UniqueKey(),
                                                imageUrl: lateEmployeeController
                                                    .lateEmployeeList[index].selfie ??
                                                    "",
                                                imageBuilder: (context, imageProvider) {
                                                  return Container(
                                                      width: 60,
                                                      height: 60,
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
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset(
                                                      icon_logo,
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                              ),

                                            ),


                                            SizedBox(width: 16,),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "DATE :  ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: text_color,
                                                            fontFamily: fontInterSemiBold),
                                                      ),
                                                      Text(
                                                        getDateOnlyInIndianFormat(
                                                            lateEmployeeController
                                                                    .lateEmployeeList[
                                                                        index]
                                                                    .date ??
                                                                DateTime(2023)),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: text_color,
                                                            fontFamily: fontInterRegular),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        "PUNCH IN :  ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: text_color,
                                                            fontFamily: fontInterSemiBold),
                                                      ),
                                                      Text(
                                                        lateEmployeeController
                                                            .lateEmployeeList[
                                                        index]
                                                            .punchTime ??"",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: text_color,
                                                            fontFamily: fontInterRegular),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        "LATE TIME :  ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: text_color,
                                                            fontFamily: fontInterSemiBold),
                                                      ),
                                                      Text(
                                                        "${lateEmployeeController
                                                            .lateEmployeeList[
                                                        index]
                                                            .lateTime ??""} ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: text_color,
                                                            fontFamily: fontInterRegular),
                                                      ),
                                                    ],
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
                            )
                          : Expanded(
                              child: Center(
                                  child: Text(
                                ("No Data Available"),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black_424448,
                                    fontFamily: fontInterSemiBold),
                              )),
                            )
                      : Center(child: CircularProgressIndicator(),),
                ],
              ))),
    );
  }
}
