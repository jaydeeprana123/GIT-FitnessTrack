import 'package:fitness_track/Screens/Authentication/Welcome/view/welcome_screen_view.dart';
import 'package:fitness_track/Screens/CMSPage/view/other_page_view.dart';
import 'package:fitness_track/Screens/Customer/Appointment/view/appointment_list_view.dart';
import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_list_view.dart';
import 'package:fitness_track/Screens/Customer/Package/view/package_list_view.dart';
import 'package:fitness_track/Screens/Customer/Workout/view/workout_list_view.dart';
import 'package:fitness_track/Screens/Dashboard/view/dashboard_view.dart';
import 'package:fitness_track/Screens/DayInDayOut/view/branch_list_view.dart';
import 'package:fitness_track/Screens/Membership/view/membership_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fitness_track/Screens/Authentication/Profile/view/profile_view.dart';
import 'package:fitness_track/Screens/splash_screen_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../../utils/InternetRealtimeConnectionChecker.dart';
import '../../../debouncer.dart';
import '../../CustomerProfile/controller/customer_profile_controller.dart';
import '../../CustomerProfile/view/customer_profile_view.dart';
import '../controller/customer_bottom_navigation_controller.dart';

class CustomerBottomNavigationView extends StatefulWidget {
  final int selectTabPosition;

  CustomerBottomNavigationView({Key? key, required this.selectTabPosition})
      : super(key: key);

  @override
  _CustomerBottomNavigationViewState createState() => _CustomerBottomNavigationViewState();
}

class _CustomerBottomNavigationViewState extends State<CustomerBottomNavigationView> {
  CusteomerBottomNavigationController bottomNavController =
      Get.put(CusteomerBottomNavigationController());
  final _debouncer = Debouncer(milliseconds: 50);

  GlobalKey _bottomNavigationKey = GlobalKey();
  bool? isLanguageChanged = false;
  CustomerProfileController profileController = Get.put(CustomerProfileController());

  // int _currentIndex = HomeTabEnum.Home.index;
  final tabs = [
    MeasurementListView(),
    WorkoutListView(),
    AppointmentListView(),

    MembershipListView(),

    CustomerProfileView(),
  ];




  @override
  void initState() {
    super.initState();

    setState(() {
      bottomNavController.getUserInfo();
      bottomNavController.currentIndex.value = widget.selectTabPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: bottomNavController.currentIndex.value != 3 &&
              bottomNavController.currentIndex.value != 2?AppBar(
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
                        ? "Measurements"
                        : bottomNavController.currentIndex.value == 1
                        ? "My Workout"
                        : bottomNavController.currentIndex.value == 2
                            ? "Appointments"
                        : bottomNavController.currentIndex.value == 3
                        ? "Membership"
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
                    logoutFromTheApp();
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
          body: tabs[bottomNavController.currentIndex.value],
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
                  fontSize: 9,
                  fontFamily: fontInterBold,
                  overflow: TextOverflow.visible),
              unselectedLabelStyle: TextStyle(
                  color: silver_9393aa,
                  height: 1.5,
                  fontSize: 9,
                  fontFamily: fontInterRegular,
                  overflow: TextOverflow.visible),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 6,
              type: BottomNavigationBarType.fixed,

              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_measurement,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_measurement,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Measurement",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_workout,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_workout,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Workout",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_appointment,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_appointment,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Appointments",
                ),

                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    icon_membership,
                    width: 20,
                    height: 20,
                    color: silver_9393aa,
                  ),
                  activeIcon: SvgPicture.asset(
                    icon_membership,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  label: "Membership",
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

  /// logout from the app
  logoutFromTheApp() async {
    var preferences = MySharedPref();
    await preferences.clearData(SharePreData.keySaveLoginModel);
    await preferences.clearData(SharePreData.keyUserType);
    Get.offAll(() => const WelcomeScreenView());
  }
}
