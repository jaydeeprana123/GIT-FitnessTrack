import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:fitness_track/CommonWidgets/attendance_success_dialog.dart';
import 'package:fitness_track/Networks/model/base_model.dart';
import 'package:fitness_track/Screens/Dashboard/model/dashboard_counter_model.dart';
import 'package:fitness_track/Screens/DayInDayOut/model/branch_list_model.dart';
import 'package:fitness_track/Screens/DayInDayOut/model/shif_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:fitness_track/Screens/Authentication/Login/model/employee_login_response_model.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../CommonWidgets/internet_connection_dialog.dart';
import '../../../CommonWidgets/time_out_dialog.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_font.dart';
import '../model/status_response_model.dart';



/// Controller
class ShiftController extends GetxController {
  RxBool isBackClose = false.obs;
  RxBool isLoading = false.obs;

  RxBool isLocationFetch = false.obs;

  RxString place = "".obs;
  RxString imagePath = "".obs;
  RxBool isButtonHide = false.obs;

  Rx<DashboardData> dashboardData = DashboardData().obs;

  String branchIdMain = "";

  RxList<ShiftData> shiftList = <ShiftData>[].obs;
  RxList<BranchData> branchList = <BranchData>[].obs;

  Rx<EmployeeLoginResponseModel> loginResponseModel = EmployeeLoginResponseModel().obs;
  RxList<String> imagePathList = <String>[].obs;
  RxString statusResponse = "0".obs;

  String currentTime = "";
  getUserInfo() async{
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPrefNew().getEmployeeLoginModel(SharePreData.keySaveLoginModel))??EmployeeLoginResponseModel();
  }
  /// get Login Status
  getLoginStatusAPI(BuildContext context, String shiftId) async {

    String url = urlBase + urlLoginStatus;

    printData("urrllll", url);

    DateTime now = DateTime.now();
    if(currentTime.isEmpty){
      currentTime = DateFormat('HH:mm:ss').format(now);
    }
    String currentDate = DateFormat('yyyy-MM-dd').format(now);
    String day = DateFormat('EEEE').format(now);

    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse(url));


    request.body = json.encode({
      "emp_id": loginResponseModel.value.data?[0].id??"",
      "date": currentDate,
      "shift_id":shiftId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );;

    printData("getLoginStatusAPI code main ", response.statusCode.toString());

    printData("getLoginStatusAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getLoginStatusAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        StatusResponseModel statusResponseModel = StatusResponseModel.fromJson(userModel);
        statusResponse.value = statusResponseModel.status.toString();

      });
    }else if (response.statusCode == 401) {

      goToWelcomeScreen();
    } else {
      print(response.reasonPhrase);
    }
  }


  /// get Branch list
  getBranchListAPI() async {
    isLoading.value = true;
    String url = urlBase + urlGetBranchList;

    printData("urrllll", url);

    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse(url));


    //
    // request.body = json.encode({
    //   "favorites_id": "1"
    // });
    request.headers.addAll(headers);

    try {

    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    isLoading.value = false;

    printData("getBranchListAPI code main ", response.statusCode.toString());

    printData("getBranchListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getBranchListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BranchListModel branchListModel = BranchListModel.fromJson(userModel);
        branchList.value = branchListModel.data ?? [];

      });
    }else if (response.statusCode == 401) {

      goToWelcomeScreen();
    } else {
      print(response.reasonPhrase);
    }

    } on SocketException catch (_) {
      isLoading.value = false;
      printData(runtimeType.toString(), "No internet connection.");
      /// Show full-screen dialog for no internet
      Get.dialog(
        NoInternetDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getBranchListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");
      /// Show full-screen dialog for timeout
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getBranchListAPI(); // Retry API call // Retry API call// Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error",  "An unexpected error occurred. Please try again.");
    }

  }

  /// get Shift list
 Future getShiftListAPI(bool isProgressLoad) async {
    isLoading.value = isProgressLoad;
    String url = urlBase + urlShiftList;

    if(isProgressLoad){
      shiftList.clear();
    }

    printData("urrllll", url);

    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse(url));
    DateTime now = DateTime.now();
    request.body = json.encode({
      "emp_id": loginResponseModel.value.data?[0].id??"",
      "date": DateFormat('yyyy-MM-dd').format(now),
      "branch_id": branchIdMain,
    });
    request.headers.addAll(headers);

    try {

    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    isLoading.value = false;

    printData("getShiftListAPI code main ", response.statusCode.toString());

    printData("getShiftListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getShiftListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        ShiftListModel shiftListModel = ShiftListModel.fromJson(userModel);
        shiftList.value = shiftListModel.data ?? [];

      });
    }else if (response.statusCode == 401) {
      goToWelcomeScreen();
    } else {
      print(response.reasonPhrase);
    }

    } on SocketException catch (_) {
      isLoading.value = false;
      printData(runtimeType.toString(), "No internet connection.");

      /// Show full-screen dialog for no internet
      Get.dialog(
        NoInternetDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getShiftListAPI(isProgressLoad); // Retry API call
          },
        ),
        barrierDismissible: false,

      );

    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");
      /// Show full-screen dialog for no internet
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getShiftListAPI(isProgressLoad); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error",  "An unexpected error occurred. Please try again.");
    }
  }


  /// call Day In Day Out api
  callDayInOutAPI(String shiftId,String branchId, String attendanceType) async {

    String url = urlBase + urlGiveAttendance;
    printData("url", url);
    DateTime now = DateTime.now();

    if(currentTime.isEmpty) {
      currentTime = DateFormat('HH:mm:ss').format(now);
    }

    String currentDate = DateFormat('yyyy-MM-dd').format(now);
    String day = DateFormat('EEEE').format(now);

    String dayNumber = "1";

    switch(day){
      case "Monday" :
        dayNumber = "1";
        break;

      case "Tuesday" :
        dayNumber = "2";
        break;

      case "Wednesday" :
        dayNumber = "3";
        break;

      case "Thursday" :
        dayNumber = "4";
        break;

      case "Friday" :
        dayNumber = "5";
        break;

      case "Saturday" :
        dayNumber = "6";
        break;

      case "Sunday" :
        dayNumber = "7";
        break;
    }


    printData("current ", currentDate + "  " + currentTime + "  " + day);
    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['authorization'] = 'Bearer $token';

    request.fields.addAll({
      'emp_id': loginResponseModel.value.data?[0].id??"",
      'shift_id': shiftId,
      'branch_id': branchIdMain,
      'date': currentDate,
      'time': currentTime,
      'day': dayNumber,
      'attendance_type': attendanceType
    });

    if(imagePath.value.isNotEmpty){
      request.files.add(await http.MultipartFile.fromPath('imageone',imagePath.value));
    }


    printData("request of callDayInOutAPI", request.fields.toString());

    try{

    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    isLoading.value = false;

    // Navigator.pop(context);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),"callDayInOutAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        imagePath.value = "";

        if (baseModel.status ?? false) {
          /// Set login model into shared preference

       //  isBackClose.value = false;

          /// Show full-screen dialog for no internet
          Get.dialog(
            AttendanceSuccessDialog(
              onClose: () {
                Get.back();
                Get.back();// Close the dialog

              },
            ),
            barrierDismissible: false,
          );


         // openAttendanceSubmissionDialog(baseModel.message??"");
        } else {
          isBackClose.value = false;
          isButtonHide.value = false;
          Get.snackbar("Error", baseModel.message??"");
        }
      });
    }else if (response.statusCode == 401) {

      goToWelcomeScreen();
    }
    else {

      isButtonHide.value = false;
      isBackClose.value = false;
      // Navigator.pop(context);
      print(response.reasonPhrase);
    }

    } on SocketException catch (_) {
      isLoading.value = false;
      isButtonHide.value = false;
      isBackClose.value = false;
      printData(runtimeType.toString(), "No internet connection.");
      /// Show full-screen dialog for no internet
      Get.dialog(
        NoInternetDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            isLoading.value = true;
            callDayInOutAPI(shiftId,branchId,attendanceType); // Retry API call // Retry API call
          },
        ),
        barrierDismissible: false,
      );

    } on TimeoutException catch (e) {
      isLoading.value = false;
      isButtonHide.value = false;
      isBackClose.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");
      /// Show full-screen dialog for timeout
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            callDayInOutAPI(shiftId,branchId,attendanceType); // Retry API call // Retry API call// Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      isButtonHide.value = false;
      isBackClose.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error",  "An unexpected error occurred. Please try again.");
    }
  }


  openAttendanceSubmissionDialog(String message){
    Get.defaultDialog(
        title: "SUBMITTED",
        middleText:
        message,
        // barrierDismissible: false,
        titlePadding: const EdgeInsets.only(
            left: 20, right: 20, top: 10),
        textConfirm: "Ok",
        titleStyle: TextStyle(
            fontSize: 15,
            fontFamily: fontInterSemiBold),
        buttonColor: Colors.white,
        confirmTextColor: color_primary,
        onConfirm: () async {
          Get.back();
          Get.back();

        });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();


    // printData("onClose", "onClose login controller");
    // Get.delete<FavesController>();
  }
}
