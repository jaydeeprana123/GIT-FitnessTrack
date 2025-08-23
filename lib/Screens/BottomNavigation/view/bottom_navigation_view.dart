import 'package:fitness_track/Enums/attendance_type_status_enum.dart';
import 'package:fitness_track/Screens/Attendance/view/branch_list_view_for_attendance.dart';
import 'package:fitness_track/Screens/Attendance/view/branch_wise_attendance_list_view.dart';
import 'package:fitness_track/Screens/Authentication/Welcome/view/welcome_screen_view.dart';
import 'dart:io';import 'package:fitness_track/Screens/Dashboard/view/dashboard_view.dart';
import 'package:fitness_track/Screens/DayInDayOut/view/branch_list_view.dart';
import 'package:fitness_track/Screens/LateEmployees/view/late_employee_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fitness_track/Screens/Authentication/Profile/view/profile_view.dart';
import 'package:fitness_track/Screens/splash_screen_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../CommonWidgets/common_green_button.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_font.dart';
import '../../../Styles/my_icons.dart';
import '../../../utils/InternetRealtimeConnectionChecker.dart';
import '../../Attendance/view/filter_ttendance_list_view.dart';
import '../../Attendance/view/employee_attendance_list_view.dart';
import '../../DayInDayOut/view/shift_list_view.dart';

import '../../Holidays/view/holiday_list_view.dart';
import '../../LeaveManagement/view/add_leave_view.dart';
import '../../LeaveManagement/view/leave_allotment_list_view.dart';
import '../../LeaveManagement/view/leave_list_view.dart';
import '../../Salary/view/salary_list_view.dart';
import '../../debouncer.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Profile/controller/profile_controller.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavigationView extends StatefulWidget {
  final int selectTabPosition;

  BottomNavigationView({Key? key, required this.selectTabPosition})
      : super(key: key);

  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  BottomNavigationController bottomNavController =
      Get.put(BottomNavigationController());
  final _debouncer = Debouncer(milliseconds: 50);

  GlobalKey _bottomNavigationKey = GlobalKey();
  bool? isLanguageChanged = false;
  ProfileController profileController = Get.put(ProfileController());

  // int _currentIndex = HomeTabEnum.Home.index;
  var tabs = <Widget>[];
  var tabsWithBranch = <Widget>[];

  @override
  void initState() {
    super.initState();

    setState(() {

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await bottomNavController.getUserInfo();
        bottomNavController.callGetAppUpdateRequired(context);
         tabs = [
          DashboardView(),
          SalaryListView(),
          ShiftListView(isFromBottomNavigation: true, branchId: "",branchName: (bottomNavController.loginResponseModel.value.data??[]).isNotEmpty?(bottomNavController.loginResponseModel.value.data?[0].branchName??""):"",),
          FilterAttendanceListView(attendanceType: bottomNavController.attendanceType.value),
          ProfileView(),
        ];

         tabsWithBranch = [
          DashboardView(),
          SalaryListView(),
          BranchListView(),
          FilterAttendanceListView(attendanceType: bottomNavController.attendanceType.value),
          ProfileView(),
        ];



        bottomNavController.currentIndex.value = widget.selectTabPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: (bottomNavController.currentIndex.value != 4) && (bottomNavController.currentIndex.value != 3)?AppBar(
            automaticallyImplyLeading: true,
            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return InkWell(
            //       onTap: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //       child: Container(
            //         margin: EdgeInsets.all(14),
            //         child: Image.asset(
            //           width: double.infinity,
            //           height: double.infinity,
            //           icon_staklist_logo,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     );
            //   },
            // ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    bottomNavController.currentIndex.value == 0
                        ? "Dashboard"
                        : bottomNavController.currentIndex.value == 1
                        ? "My Salary"
                        : bottomNavController.currentIndex.value == 2
                            ? ((bottomNavController.loginResponseModel.value.data?[0].regularShiftApply??"0") == "1")?"Branches":"Shifts"
                            : bottomNavController.currentIndex.value == 3
                                ? "My Attendance"
                                : bottomNavController.currentIndex.value == 4
                                    ? "My Profile"
                                    : "My Profile",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: fontInterSemiBold),
                  ),
                ),

                bottomNavController.currentIndex.value == 0
                    ? InkWell(
                  onTap: () {
                    openLogoutDialog();
                  },
                  child: SvgPicture.asset(
                    icon_logout,
                    width: 22,
                    height: 22,
                    color: Colors.white,
                  ),
                )
                    : SizedBox(),
              ],
            ),
            backgroundColor: color_primary,
          ):null,
          backgroundColor: Colors.white,


        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                      color: color_primary
                  ),
                  child: Column(
                    children: [
                      ((bottomNavController.loginResponseModel.value.data?[0].id??0).toString()) != "0"
                          ? (bottomNavController.loginResponseModel.value.data?[0].photo ??
                          "")
                          .isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(58.r),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: bottomNavController.loginResponseModel.value.data?[0].photo ?? "",
                          imageBuilder: (context, imageProvider) {
                            return Container(
                                height: 80,
                                width: 80,
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
                                img_photo_place_holder,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                img_photo_place_holder,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                        ),
                      )

                          : Image.asset(
                        icon_logo,
                        height: 80,
                        width: 80,
                      )
                          : Image.asset(
                        icon_logo,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: 8),
                      Text(
                        " ${bottomNavController.loginResponseModel.value.data?[0].name ??
                            ""}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontInterRegular,
                            fontSize: 14),
                      ),
                      Text(
                        bottomNavController.loginResponseModel.value.data?[0].email ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontInterRegular,
                            fontSize: 13),
                      ),


                    ],
                  )),
              Container(
                padding: EdgeInsets.only(top: 26,left: 16),
                child: Column(
                  children: [

                    InkWell(
                      onTap: () {

                        Get.to(HolidayListView());

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              icon_holiday,
                              width: 20,
                              height: 20,
                              color: color_primary,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Holidays",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 14,
                                  fontFamily: fontInterRegular),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 16, right: 12),
                      height: 0.25,
                      width: double.infinity,
                      color: color_primary,
                    ),


                    /// Here if person is a branch manager
                    bottomNavController.loginResponseModel.value.data?[0].designationId == "2"? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {

                            Get.to(LateEmployeeListView());

                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  icon_leave,
                                  width: 20,
                                  height: 20,
                                  color: color_primary,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Late Employees",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 14,
                                      fontFamily: fontInterRegular),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 16, right: 12),
                          height: 0.25,
                          width: double.infinity,
                          color: color_primary,
                        ),
                      ],
                    ):SizedBox(),


                    InkWell(
                      onTap: () {

                        Get.to(LeaveListView());

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              icon_leave,
                              width: 20,
                              height: 20,
                              color: color_primary,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "My Leaves",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 14,
                                  fontFamily: fontInterRegular),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 16, right: 12),
                      height: 0.25,
                      width: double.infinity,
                      color: color_primary,
                    ),

                    InkWell(
                      onTap: () {

                        Get.to(LeaveAllotmentListView());

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              icon_allotment,
                              width: 18,
                              height: 18,
                              color: color_primary,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Leave Allotments",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 14,
                                  fontFamily: fontInterRegular),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      height: 0.25,
                      width: double.infinity,
                      color: color_primary,
                    ),



                    ((bottomNavController.loginResponseModel.value.data?[0].branchId??"0") == "0")?Column(
                      children: [
                        InkWell(
                          onTap: () {

                            Get.to(BranchListViewForAttendance());

                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  icon_attendance,
                                  width: 18,
                                  height: 18,
                                  color: color_primary,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Branch Wise Attendance",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 14,
                                      fontFamily: fontInterRegular),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          height: 0.25,
                          width: double.infinity,
                          color: color_primary,
                        ),
                      ],
                    ):SizedBox(),


                    Column(
                      children: [
                        InkWell(
                          onTap: () {

                            Get.to(EmployeeAttendanceListView());

                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  icon_attendance,
                                  width: 18,
                                  height: 18,
                                  color: color_primary,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "My Attendance",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 14,
                                      fontFamily: fontInterRegular),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          height: 0.25,
                          width: double.infinity,
                          color: color_primary,
                        ),
                      ],
                    ),



                    InkWell(
                      onTap: () {
                        openLogoutDialog();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              icon_logout,
                              width: 18,
                              height: 18,
                              color: color_primary,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 14,
                                  fontFamily: fontInterRegular),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Container(
                    //    margin: EdgeInsets.only(left: 12, right: 12),
                    //   height: 0.25,
                    //   width: double.infinity,
                    //   color: light_red,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),



          body: tabs.isNotEmpty?((bottomNavController.loginResponseModel.value.data?[0].regularShiftApply??"0") == "0")?tabs[bottomNavController.currentIndex.value]:tabsWithBranch[bottomNavController.currentIndex.value]:Center(child: CircularProgressIndicator(),),
          bottomNavigationBar:
              // SizedBox(
              //   height: 60.h,
              //   child:
          Obx(
                () => BottomNavigationBar(
              key: _bottomNavigationKey,
              backgroundColor: color_primary,
              selectedItemColor: Colors.white,
              unselectedItemColor: silver_9393aa,
              currentIndex: bottomNavController.currentIndex.value,
              // selectedFontSize: 12,
              // unselectedFontSize: 12,
              selectedLabelStyle: TextStyle(
                  color: Colors.white,
                  height: 1.5,
                  fontSize: 10,
                  fontFamily: fontInterBold,
                  overflow: TextOverflow.visible),
              unselectedLabelStyle: TextStyle(
                  color: silver_9393aa,
                  height: 1.5,
                  fontSize: 10,
                  fontFamily: fontInterRegular,
                  overflow: TextOverflow.visible),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 6,
              type: BottomNavigationBarType.fixed,

              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_dashboard,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_dashboard,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_salary,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_salary,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "My Salary",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_shift,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_shift,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Day In/Out",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_attendance,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_attendance,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Attendance",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_settings,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_settings,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Settings",
                ),
              ],
              onTap: (index) {
                setState(() {
                  bottomNavController.currentIndex.value = index;
                });
              },
            ),
          ),

          // ),
        ));
  }


  openLogoutDialog(){
    Get.defaultDialog(
        title: "LOGOUT",
        middleText:
        "Are you sure want to logout from the app?",
        barrierDismissible: false,
        titlePadding: const EdgeInsets.only(
            left: 20, right: 20, top: 10),
        textConfirm: "Yes",
        textCancel: "No",
        titleStyle: TextStyle(
            fontSize: 15,
            fontFamily: fontInterSemiBold),
        buttonColor: Colors.white,
        confirmTextColor: color_primary,
        onCancel: () {
          Navigator.pop(context);
        },
        onConfirm: () async {
          Navigator.pop(context);
          logoutFromTheApp();
        });
  }

  /// logout from the app
  logoutFromTheApp() async {

    var preferences = MySharedPref();
    await preferences.clearData(SharePreData.keySaveLoginModel);
    Get.offAll(() => const WelcomeScreenView());
  }



}
