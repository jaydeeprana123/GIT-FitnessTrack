import 'dart:developer';
import 'dart:io';

import 'package:fitness_track/Screens/DayInDayOut/model/branch_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/add_leave_request_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_category_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_shift_list_model.dart';
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
import '../../DayInDayOut/controller/shift_controller.dart';
import '../../DayInDayOut/model/shif_list_model.dart';
import '../controller/leave_management_controller.dart';
import '../model/leave_list_model.dart';


class AddLeaveView extends StatefulWidget {

  String? favouriteId;

  AddLeaveView({Key? key, this.favouriteId}) : super(key: key);

  @override
  State<AddLeaveView> createState() => _AddLeaveViewState();
}

class _AddLeaveViewState extends State<AddLeaveView> {
  ShiftController shiftController = Get.put(ShiftController());

  /// Initialize the controller
  LeaveManagementController controller = Get.find<LeaveManagementController>();
  String? strLeaveCategoryId;

  @override
  void initState() {
    log(":::::::::::::::LoginViaMobileNumView InitState::::::::::Token");


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();

      controller.getLeaveCategoryListAPI();

      controller.leaveRequestDataList.add(LeaveRequestData());
      // if ((controller.loginResponseModel.value.data?[0].branchId ?? "")
      //     .isNotEmpty) {
      //   controller.leaveRequestDataList[0].branchId =
      //       controller.loginResponseModel.value.data?[0].branchId ?? "0";
      //   controller.getShiftListAPI(context, 0);
      // } else {
      //   shiftController.getBranchListAPI(context);
      // }

      controller.leaveRequestDataList[0].branchId =
          controller.loginResponseModel.value.data?[0].branchId ?? "0";
      controller.getShiftListAPI(0);

      controller.remarksEditingController.value.clear();
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
            "Add Leave",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: fontInterRegular),
          ),

        ),

        body: Obx(() =>
            Container(
              height: double.infinity,
              child: Stack(
                children: [

                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text("SELECT LEAVE TYPE",
                                    style: TextStyle(color: text_color,
                                        fontSize: 12.sp,
                                        fontFamily: fontInterMedium)),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(
                                      color: text_color, width: 0.5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child:


                                  DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Leave Type',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: _addDividersAfterLeaveCategoryItems(controller.leaveCategoryList ?? []),
                                    value: strLeaveCategoryId,
                                    onChanged: (String? value) {
                                      setState(() {
                                        strLeaveCategoryId = value;
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
                                      customHeights: _getCustomItemsHeights(controller.leaveCategoryList.length),
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
                                  //     padding: EdgeInsets.only(right: 14),
                                  //     child: Text(
                                  //       'Select Leave Type',
                                  //       style: TextStyle(
                                  //           color: text_color,
                                  //           fontFamily: fontInterRegular,
                                  //           fontSize: 14),
                                  //
                                  //       overflow: TextOverflow.ellipsis,
                                  //     ),
                                  //   ),
                                  //   items: (controller.leaveCategoryList ?? [])
                                  //       .isNotEmpty
                                  //       ? (controller.leaveCategoryList.value ??
                                  //       [])
                                  //       .map((LeaveCategoryData value) =>
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
                                  //             BorderRadius.all(
                                  //                 Radius.circular(11.r)),
                                  //             border: Border.all(width: 0.5,
                                  //                 color: Colors.white),
                                  //           ),
                                  //           child: Text(
                                  //             value.name ?? "",
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
                                  //   value: strLeaveCategoryId,
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       strLeaveCategoryId = value;
                                  //
                                  //       printData("strLeaveCategoryId",
                                  //           strLeaveCategoryId ?? "");
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

                          SizedBox(height: 8,),

                          InkWell(
                            onTap: () {
                              var leaveData = LeaveRequestData();
                              if ((controller.loginResponseModel.value.data?[0]
                                  .branchId ?? "").isNotEmpty) {
                                leaveData.branchId =
                                    controller.loginResponseModel.value.data?[0]
                                        .branchId ?? "";
                                leaveData.shiftDataList =
                                    controller.leaveRequestDataList[0]
                                        .shiftDataList;
                              }
                              controller.leaveRequestDataList.add(leaveData);

                              setState(() {

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                              margin: EdgeInsets.only(top: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                      color: text_color, width: 0.5),
                                  color: color_primary
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                SvgPicture.asset(
                                  icon_add_circle,
                                  width: 18,
                                  height: 18,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                    "Add New",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: fontInterSemiBold,
                                        color: Colors.white)),

                              ],),
                            ),
                          ),


                          for(int i = 0; i <
                              controller.leaveRequestDataList.length; i++)
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Card(
                                color: light_orange_fc9875,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.r)),
                                      border: Border.all(
                                          width: 1,
                                          color: line_gray_e2e2e6),
                                      color: light_grey),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [

                                      Visibility(
                                        visible: i != 0,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.leaveRequestDataList
                                                  .removeAt(i);
                                              setState(() {

                                              });
                                            },
                                            child: SvgPicture.asset(
                                              icon_cancel_close,
                                              width: 20,
                                              height: 20,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Text("SELECT DATE", style: TextStyle(
                                          color: text_color,
                                          fontSize: 12,
                                          fontFamily: fontInterMedium)),

                                      SizedBox(height: 3,),

                                      InkWell(
                                        onTap: () async {
                                          printData("click on", "birth");
                                          FocusScope.of(context).unfocus();
                                          DateTime? dateTime = await Helper()
                                              .selectDateInYYYYMMDD(context,
                                              SelectDateEnum.Future.outputVal);

                                          controller.leaveRequestDataList[i]
                                              .leaveDateEditingController
                                              ?.text = getDateFormtYYYYMMDDOnly(
                                              dateTime.toString());
                                          controller.leaveRequestDataList[i]
                                              .leaveDate =
                                              getDateFormtYYYYMMDDOnly(
                                                  dateTime.toString());
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(11.r)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: line_gray_e2e2e6),
                                                color: Colors.white),
                                            child: Text(controller
                                                .leaveRequestDataList[i]
                                                .leaveDate ?? "",
                                                style: TextStyle(
                                                    color: subtitle_black_101623,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: fontInterMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 13.sp))
                                        ),
                                      ),

                                      (controller.loginResponseModel.value
                                          .data?[0].branchId ?? "").isEmpty
                                          ? Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text("SELECT BRANCH",
                                                style: TextStyle(
                                                    color: text_color,
                                                    fontSize: 12.sp,
                                                    fontFamily: fontInterMedium)),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(11),
                                              border: Border.all(
                                                  color: text_color,
                                                  width: 0.5),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child:

                                              DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: Text(
                                                  'Select Branch',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context).hintColor,
                                                  ),
                                                ),
                                                items: _addDividersAfterBranchItems(shiftController.branchList ?? []),
                                                value: controller
                                                    .leaveRequestDataList[i]
                                                    .branchId,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    controller
                                                        .leaveRequestDataList[i]
                                                        .branchId = value;
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
                                                  customHeights: _getCustomItemsHeights(shiftController.branchList.length),
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
                                              //     padding: EdgeInsets.only(
                                              //         right: 10.w),
                                              //     child: SvgPicture.asset(
                                              //       icon_down_arrow,
                                              //       color: text_color,
                                              //     ),
                                              //   ),
                                              //   hint: Container(
                                              //     padding: EdgeInsets.only(
                                              //         right: 14),
                                              //     child: Text(
                                              //       'Select Branch',
                                              //       style: TextStyle(
                                              //           color: text_color,
                                              //           fontFamily: fontInterRegular,
                                              //           fontSize: 14),
                                              //
                                              //       overflow: TextOverflow
                                              //           .ellipsis,
                                              //     ),
                                              //   ),
                                              //   items: (shiftController
                                              //       .branchList ?? [])
                                              //       .isNotEmpty
                                              //       ? (shiftController
                                              //       .branchList.value ?? [])
                                              //       .map((BranchData value) =>
                                              //       DropdownMenuItem<String>(
                                              //         value: value.id
                                              //             .toString(),
                                              //
                                              //         child: Container(
                                              //           padding:
                                              //           EdgeInsets.only(
                                              //               right: 14),
                                              //           // color: Colors.red,
                                              //           decoration: BoxDecoration(
                                              //             color: Colors.white,
                                              //             borderRadius:
                                              //             BorderRadius.all(
                                              //                 Radius.circular(
                                              //                     11.r)),
                                              //             border: Border.all(
                                              //                 width: 0.5,
                                              //                 color: Colors
                                              //                     .white),
                                              //           ),
                                              //           child: Text(
                                              //             value.name ?? "",
                                              //             style: TextStyle(
                                              //               fontSize: 14,
                                              //               fontFamily: fontInterMedium,
                                              //               color: Colors.black,
                                              //             ),
                                              //             overflow: TextOverflow
                                              //                 .ellipsis,
                                              //           ),
                                              //         ),
                                              //       ))
                                              //       .toList()
                                              //       : <String>[].map((
                                              //       String value) {
                                              //     return const DropdownMenuItem<
                                              //         String>(
                                              //       value: "",
                                              //       child: SizedBox(),
                                              //     );
                                              //   }).toList(),
                                              //   value: controller
                                              //       .leaveRequestDataList[i]
                                              //       .branchId,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       controller
                                              //           .leaveRequestDataList[i]
                                              //           .branchId = value;
                                              //       controller.getShiftListAPI(
                                              //           context, i);
                                              //
                                              //       printData("shiftId",
                                              //           controller
                                              //               .leaveRequestDataList[i]
                                              //               .branchId ?? "");
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
                                      )
                                          : SizedBox(),


                                      SizedBox(height: 12,),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text("SELECT SHIFT",
                                                style: TextStyle(
                                                    color: text_color,
                                                    fontSize: 12.sp,
                                                    fontFamily: fontInterMedium)),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(11),
                                                border: Border.all(
                                                    color: text_color,
                                                    width: 0.5),
                                                color: Colors.white
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child:

                                              DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: Text(
                                                  'Select Shift',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context).hintColor,
                                                  ),
                                                ),
                                                items: _addDividersAfterShiftDataItems(controller
                                                    .leaveRequestDataList[i]
                                                    .shiftDataList ?? []),
                                                value: controller
                                                    .leaveRequestDataList[i]
                                                    .shiftId,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    controller
                                                        .leaveRequestDataList[i]
                                                        .shiftId= value;
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
                                                  customHeights: _getCustomItemsHeights(controller
                                                      .leaveRequestDataList[i]
                                                      .shiftDataList?.length??0),
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
                                              //     padding: EdgeInsets.only(
                                              //         right: 10.w),
                                              //     child: SvgPicture.asset(
                                              //       icon_down_arrow,
                                              //       color: text_color,
                                              //     ),
                                              //   ),
                                              //   hint: Container(
                                              //     padding: EdgeInsets.only(
                                              //         right: 14),
                                              //     child: Text(
                                              //       'Select Shift',
                                              //       style: TextStyle(
                                              //           color: text_color,
                                              //           fontFamily: fontInterRegular,
                                              //           fontSize: 14),
                                              //
                                              //       overflow: TextOverflow
                                              //           .ellipsis,
                                              //     ),
                                              //   ),
                                              //   items: (controller
                                              //       .leaveRequestDataList[i]
                                              //       .shiftDataList ?? [])
                                              //       .isNotEmpty
                                              //       ? (controller
                                              //       .leaveRequestDataList[i]
                                              //       .shiftDataList ?? [])
                                              //       .map((LeaveShiftData value) =>
                                              //       DropdownMenuItem<String>(
                                              //         value: value.id
                                              //             .toString(),
                                              //
                                              //         child: Container(
                                              //           padding:
                                              //           EdgeInsets.only(
                                              //               right: 14),
                                              //           // color: Colors.red,
                                              //           decoration: BoxDecoration(
                                              //             color: Colors.white,
                                              //             borderRadius:
                                              //             BorderRadius.all(
                                              //                 Radius.circular(
                                              //                     11.r)),
                                              //             border: Border.all(
                                              //                 width: 0.5,
                                              //                 color: Colors
                                              //                     .white),
                                              //           ),
                                              //           child: Text(
                                              //             value.name ?? "",
                                              //             style: TextStyle(
                                              //               fontSize: 14,
                                              //               fontFamily: fontInterMedium,
                                              //               color: Colors.black,
                                              //             ),
                                              //             overflow: TextOverflow
                                              //                 .ellipsis,
                                              //           ),
                                              //         ),
                                              //       ))
                                              //       .toList()
                                              //       : <String>[].map((
                                              //       String value) {
                                              //     return const DropdownMenuItem<
                                              //         String>(
                                              //       value: "",
                                              //       child: SizedBox(),
                                              //     );
                                              //   }).toList(),
                                              //   value: controller
                                              //       .leaveRequestDataList[i]
                                              //       .shiftId,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       controller
                                              //           .leaveRequestDataList[i]
                                              //           .shiftId = value;
                                              //       printData("shiftId",
                                              //           controller
                                              //               .leaveRequestDataList[i]
                                              //               .shiftId ?? "");
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
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 2, top: 24),
                            child: Text("REMARKS", style: TextStyle(
                                color: text_color,
                                fontSize: 12,
                                fontFamily: fontInterMedium)),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(11.r)),
                              border: Border.all(
                                  width: 1, color: line_gray_e2e2e6),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.r),
                              child: TextFormField(
                                scrollPadding: EdgeInsets.only(
                                    bottom: MediaQuery
                                        .of(context)
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
                                  if (value
                                      .toString()
                                      .isNotEmpty) {
                                    return null;
                                  } else {
                                    printData("value", value.toString());
                                    return 'Enter Comment';
                                  }
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 38.0, right: 38, bottom: 30),
                              child: CommonGreenButton("SUBMIT", () {
                                FocusScope.of(context).unfocus();

                                bool isDataPerfect = true;

                                if ((strLeaveCategoryId ?? "").isEmpty) {
                                  snackBar(context, "Select Leave Type");
                                  return;
                                }
                                List<String> totalDays = [];
                                List<String> totalShift = [];


                                for (int i = 0; i <
                                    controller.leaveRequestDataList
                                        .length; i++) {

                                  bool dayIsAdded = false;
                                  bool shiftIsAdded = false;

                                  for (int j = 0; j < totalDays.length; j++) {
                                    if((controller.leaveRequestDataList[i].leaveDate??"") == totalDays[j]){
                                      dayIsAdded = true;
                                    }
                                  }

                                  if(!dayIsAdded){
                                    totalDays.add(controller.leaveRequestDataList[i].leaveDate??"");
                                  }

                                  for (int z = 0; z < totalShift.length; z++) {
                                    if((controller.leaveRequestDataList[i].shiftId??"") == totalShift[z]){
                                      shiftIsAdded = true;
                                    }
                                  }

                                  if(!shiftIsAdded){
                                    totalShift.add(controller.leaveRequestDataList[i].shiftId??"");
                                  }


                                  if ((controller.leaveRequestDataList[i]
                                      .leaveDate ?? "").isEmpty) {
                                    snackBar(context, "Select Date");
                                    isDataPerfect = false;
                                    return;
                                  } else if ((controller.leaveRequestDataList[i]
                                      .shiftId ?? "").isEmpty) {
                                    snackBar(context, "Select Shift");
                                    isDataPerfect = false;
                                    return;
                                  }
                                }

                                checkNet(context).then((value) {
                                  controller.addLeaveRequestModel =
                                      AddLeaveRequestModel();
                                  controller.addLeaveRequestModel.branchId =
                                      controller.leaveRequestDataList[0]
                                          .branchId ?? "";
                                  controller.addLeaveRequestModel.remarks =
                                      controller.remarksEditingController.value
                                          .text;


                                  controller.addLeaveRequestModel.totalDays =
                                      totalDays.length.toString();
                                  controller.addLeaveRequestModel.totalShift =
                                      totalShift.length.toString();

                                  controller.addLeaveRequestModel.empId =
                                      controller.loginResponseModel.value
                                          .data?[0].id ?? "";

                                  controller.addLeaveRequestModel
                                      .leaveCategoryId =
                                      strLeaveCategoryId ?? "";

                                  controller.addLeaveRequestModel.dataLeave =
                                  [];
                                  controller.addLeaveRequestModel.dataLeave
                                      ?.addAll(
                                      controller.leaveRequestDataList.value);

                                  controller.callAddLeaveAPI();
                                });
                              }, button_Color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if(controller.isLoading.value)Center(child: CircularProgressIndicator(),)

                ],
              ),
            )),
      ),
    );
  }


  List<DropdownMenuItem<String>> _addDividersAfterLeaveCategoryItems(List<LeaveCategoryData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final LeaveCategoryData item in items) {
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
  List<DropdownMenuItem<String>> _addDividersAfterBranchItems(List<BranchData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final BranchData item in items) {
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

  List<DropdownMenuItem<String>> _addDividersAfterShiftDataItems(List<LeaveShiftData> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final LeaveShiftData item in items) {
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
