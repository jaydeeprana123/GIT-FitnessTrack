import 'dart:async';
import 'dart:convert';
import 'package:fitness_track/Enums/attendance_type_status_enum.dart';
import 'package:fitness_track/Screens/Authentication/Login/view/employee_login_via_otp_view.dart';
import 'package:fitness_track/Screens/Dashboard/model/app_version_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'package:fitness_track/Styles/my_icons.dart';
import '../../../CommonWidgets/common_widget.dart';
import '../../../Networks/api_endpoint.dart';
import '../../../Networks/model/base_model.dart';
import '../../../Styles/my_colors.dart';
import '../../../Utils/preference_utils.dart';
import '../../../Utils/share_predata.dart';
import '../../Authentication/Login/model/employee_login_response_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BottomNavigationController extends GetxController {
  RxBool isBackClose = false.obs;
  RxInt currentIndex = 0.obs;
  RxString attendanceType = AttendanceTypeEnum.all.outputVal.obs;
  RxBool isAppUpdate = false.obs;
  RxBool isForceUpdate = false.obs;
  List<String> myAccountList = [
    "My Profile",
    "My Favourite",
    "My Notifications",
  ];

  Rx<AppVersionData> appVersionData = AppVersionData().obs;

  List<String> myAccountIconList = [
    icon_my_profile,
    icon_favourite,
    icon_nav_notification,
  ];

  List<String> othersList = [
    "About Us",
    "Terms & Conditions",
    "Privacy Policy"

  ];

  List<String> othersIconList = [
    icon_about,
    icon_faq,
    icon_terms,
    icon_privacy,

  ];

  Rx<EmployeeLoginResponseModel> loginResponseModel = EmployeeLoginResponseModel().obs;
  RxString daily = "Daily".obs;

  @override
  void onInit() {
   // currentIndex.value = HomeTabEnum.Home.index;
    super.onInit();
  }

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value =
        await MySharedPref().getEmployeeLoginModel(SharePreData.keySaveLoginModel)??EmployeeLoginResponseModel();
  }


  /// account delete api call
  accountDeleteApi(
      BuildContext context,
      ) async {
    // onLoading(context, "Loading..");

    String url = urlBase + urlAccountDelete;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "customer_id": loginResponseModel.value.data?[0].id ?? "0",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );;

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "chat form API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel model = BaseModel.fromJson(userModel);

        if (model.status??false) {
          snackBar(context, model.message??"");

          Get.offAll(EmployeeLoginViaOTPView());

        } else {
          snackBar(context, model.message??"");
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }



/// app update is required or not
Future callGetAppUpdateRequired(BuildContext context ) async {

  printData("callGetAppUpdateRequired", "callGetAppUpdateRequired");
  String url = urlBase + urlAppUpdateCheck;

  String token = await MySharedPref().getStringValue(SharePreData.keyAccessToken);
  printData("tokenn", token);

  var headers = {'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'};
  var request = http.Request('POST', Uri.parse(url));
  request.body = json.encode({
    "id": "1",
    // "id": loginResponseModel.value.data?[0].id ?? "0",
  });
  request.headers.addAll(headers);

  printData("request.body", request.body);

  try {
  http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {

          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );;
  printData("callGetAppUpdateRequired response", response.statusCode.toString());

  if (response.statusCode == 200) {
    await response.stream.bytesToString().then((valueData) async {
      printData(runtimeType.toString(), "callGetAppUpdateRequired API value ${valueData}");
      Map<String, dynamic> map = json.decode(valueData);
      AppVersionModel appVersionModel = AppVersionModel.fromJson(map);
      appVersionData.value = appVersionModel.data?[0]??AppVersionData();

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      double serverBuildVersion = 0.0;
      if (Platform.isIOS) {
        serverBuildVersion = double.parse(appVersionData.value.iosVersion ?? "0");
      }else{
        serverBuildVersion = double.parse(appVersionData.value.androidVersion ?? "0");
      }


      printData("buildNumber ", buildNumber);
      if (int.parse(buildNumber) <
          serverBuildVersion) {
        isAppUpdate.value = true;

        printData("isAppUpdate", "true");

        if ((appVersionData.value.isForceUpdate ?? "false") == "true") {
          printData("isForceUpdate", "true");
          isForceUpdate.value = true;
        } else {

          printData("isForceUpdate", "false");
          isForceUpdate.value = false;
        }
      }else{
        printData("else", "part");
        isForceUpdate.value = false;
        isAppUpdate.value = false;
      }

      checkVersion(context);
    });
  } else {
    print(response.reasonPhrase);
  }

  } on SocketException catch (_) {
    printData(runtimeType.toString(), "No internet connection.");
    // Show an internet error message to the user
   // Get.snackbar("Connection", "No internet connection. Please check your network and try again.");
  } on TimeoutException catch (e) {
    printData(runtimeType.toString(), "Timeout error: ${e.message}");
    // Show a timeout error message to the user
  //  Get.snackbar("Time Out", "Request timed out. Please try again.");
  } catch (e) {
    printData(runtimeType.toString(), "Unexpected error: $e");
    // Handle other exceptions
   // Get.snackbar("Error",  "An unexpected error occurred. Please try again.");
  }
}



checkVersion(BuildContext context){
  if(!isAppUpdate.value && !isForceUpdate.value){

  }else if(isAppUpdate.value && !isForceUpdate.value){
    /// This default dialog of the Getx
    Get.defaultDialog(

        title: "App Update",
        barrierDismissible: false,
        middleText: "App update is available. Please click on update button for to update the app.",
        titlePadding: const EdgeInsets.only(
            left: 20, right: 20, top: 25),
        textConfirm: "Update",
        textCancel: "Continue",
        buttonColor: Colors.white,
        cancelTextColor: Colors.black,
        confirmTextColor: bg_btn_199a8e,
        onCancel: () {
          Navigator.pop(context);
        },
        onConfirm: () async{
          Uri launchUri =
          Uri.parse("https://play.google.com/store/apps/details?id=com.fitness.ftg");
          if (Platform.isIOS) {
            launchUri =
                Uri.parse("https://apps.apple.com/in/app/ftg-services/id6505065682");
          }


          await launchUrl(launchUri,
              mode: LaunchMode
                  .externalApplication);
        });
  }else if(isAppUpdate.value && isForceUpdate.value){

    isBackClose.value = true;

    /// This default dialog of the Getx
    Get.defaultDialog(
        title: "App Update",
        middleText: "App update is available. Please click on update button for to update the app.",
        barrierDismissible: false,
        titlePadding: const EdgeInsets.only(
            left: 20, right: 20, top: 25),
        textConfirm: "Update",
        buttonColor: Colors.white,
        confirmTextColor: bg_btn_199a8e,
        onConfirm: () async{

          Uri launchUri =
          Uri.parse("https://play.google.com/store/apps/details?id=com.fitness.ftg");
          if (Platform.isIOS) {
            launchUri =
                Uri.parse("https://apps.apple.com/in/app/ftg-services/id6505065682");
          }

          await launchUrl(launchUri,
              mode: LaunchMode
                  .externalApplication);
        });
  }
}


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    printData("onClose", "onClose bottom navigation controller");
    Get.delete<BottomNavigationController>();
  }



}
