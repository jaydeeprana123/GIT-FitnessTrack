import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_allotment_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_category_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_list_model.dart';
import 'package:fitness_track/Screens/LeaveManagement/model/leave_shift_list_model.dart';
import 'package:intl/intl.dart';

import 'package:fitness_track/Screens/Holidays/model/holiday_list_model.dart';
import 'package:fitness_track/Screens/Salary/model/salary_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_track/Screens/Authentication/Login/model/employee_login_response_model.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../CommonWidgets/internet_connection_dialog.dart';
import '../../../CommonWidgets/time_out_dialog.dart';
import '../../../Networks/model/base_model.dart';
import '../../DayInDayOut/model/shif_list_model.dart';
import '../model/add_leave_request_model.dart';

/// Controller
class LeaveManagementController extends GetxController {
  AddLeaveRequestModel addLeaveRequestModel = AddLeaveRequestModel();
  Rx<TextEditingController> remarksEditingController =
      TextEditingController().obs;
  RxList<LeaveListData> leaveList = <LeaveListData>[].obs;
  Rx<EmployeeLoginResponseModel> loginResponseModel =
      EmployeeLoginResponseModel().obs;
  List<LeaveShiftData> allLeaveShiftDataList = [];

  RxBool isLoading = false.obs;

  /// Leave allotment
  RxList<LeaveAllotmentData> leaveAllotmentList = <LeaveAllotmentData>[].obs;

  Rx<LeaveListData> selectedLeaveData = LeaveListData().obs;
  RxList<LeaveRequestData> leaveRequestDataList = <LeaveRequestData>[].obs;
  RxList<LeaveCategoryData> leaveCategoryList = <LeaveCategoryData>[].obs;

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref()
            .getEmployeeLoginModel(SharePreData.keySaveLoginModel)) ??
        EmployeeLoginResponseModel();
  }

  /// get Shift list
  getShiftListAPI(int leaveListPosition) async {
    isLoading.value = true;

    String url = urlBase + urlLeaveShiftList;

    printData("urrllll", url);

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));
    DateTime now = DateTime.now();
    request.body = json.encode({
      "emp_id": loginResponseModel.value.data?[0].id ?? "",
      // "date": DateFormat('yyyy-MM-dd').format(now),
      // "branch_id": leaveRequestDataList[leaveListPosition].branchId??"",
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        },
      );

      isLoading.value = false;

      printData("getShiftListAPI code main ", response.statusCode.toString());

      printData("getShiftListAPI request.body ", request.body);

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "getShiftListAPI place API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          LeaveShiftListModel shiftListModel =
              LeaveShiftListModel.fromJson(userModel);
          allLeaveShiftDataList = shiftListModel.data ?? [];
          leaveRequestDataList[leaveListPosition].shiftDataList =
              shiftListModel.data ?? [];
        });
      } else if (response.statusCode == 401) {
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
            getShiftListAPI(leaveListPosition); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getShiftListAPI(leaveListPosition); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }
  }

  /// get leave category list
  getLeaveCategoryListAPI() async {
    String url = urlBase + urlLeaveCategoryList;

    isLoading.value = true;

    printData("urrllll", url);

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse(url));
    DateTime now = DateTime.now();
    // request.body = json.encode({
    //   "emp_id": loginResponseModel.value.data?[0].id??"",
    //   "date": DateFormat('yyyy-MM-dd').format(now),
    //   "branch_id": leaveRequestDataList[leaveListPosition].branchId??"",
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
      printData(
          "getLeaveCategoryListAPI code main ", response.statusCode.toString());

      printData("getLeaveCategoryListAPI request.body ", request.body);

      isLoading.value = false;

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "getLeaveCategoryListAPI place API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          LeaveCategoryListModel leaveCategoryListModel =
              LeaveCategoryListModel.fromJson(userModel);
          leaveCategoryList.value = leaveCategoryListModel.data ?? [];
        });
      } else if (response.statusCode == 401) {
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
            getLeaveCategoryListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getLeaveCategoryListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }
  }

  /// add leave api call
  callAddLeaveAPI() async {
    isLoading.value = true;

    String url = urlBase + urlLeaveAdd;
    printData("callAddLeaveAPI url", url);
    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    printData("callAddLeaveAPI headers", headers.toString());

    request.body = addLeaveRequestModelToJson(addLeaveRequestModel);
    request.headers.addAll(headers);

    printData("callAddLeaveAPI boddyyy", request.body);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "callInsertFavCommentAPI API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          BaseModel baseModel = BaseModel.fromJson(userModel);

          if (baseModel.status ?? false) {
            Get.snackbar("Leave", baseModel.message ?? "");
            Get.back();
          } else {
            Get.snackbar("Leave", baseModel.message ?? "");
          }
        });
      } else if (response.statusCode == 401) {
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
            callAddLeaveAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            callAddLeaveAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }
  }

  /// edit leave api call
  callEditLeaveAPI() async {
    isLoading.value = true;

    String url = urlBase + urlLeaveEdit;
    printData("callEditLeaveAPI url", url);
    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    printData("callEditLeaveAPI headers", headers.toString());

    request.body = addLeaveRequestModelToJson(addLeaveRequestModel);
    request.headers.addAll(headers);

    printData("callEditLeaveAPI boddyyy", request.body);

    try {
      http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "callEditLeaveAPI API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          BaseModel baseModel = BaseModel.fromJson(userModel);

          if (baseModel.status ?? false) {

            Get.snackbar("Leave", baseModel.message??"");
            Get.back();
          } else {
            Get.snackbar("Leave", baseModel.message??"");
          }
        });
      } else if (response.statusCode == 401) {
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
            callEditLeaveAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            callEditLeaveAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }
  }

  /// get allotment list
  getLeaveAllotmentListAPI() async {
    isLoading.value = true;
    String url = urlBase + urlLeaveAllotmentList;

    printData("urrllll", url);

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    request.body =
        json.encode({"emp_id": loginResponseModel.value.data?[0].id ?? ""});
    request.headers.addAll(headers);

    try{

    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );
    isLoading.value = false;

    printData(
        "getLeaveAllotmentListAPI code main ", response.statusCode.toString());

    printData("getLeaveAllotmentListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "getLeaveAllotmentListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        LeaveAllotmentListModel leaveAllotmentListModel =
            LeaveAllotmentListModel.fromJson(userModel);
        leaveAllotmentList.value = leaveAllotmentListModel.data ?? [];
      });
    } else if (response.statusCode == 401) {
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
            getLeaveAllotmentListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getLeaveAllotmentListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }

  }

  /// get leave list
  getLeaveListAPI() async {
    isLoading.value = true;
    String url = urlBase + urlLeaveList;

    printData("urrllll", url);

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    request.body =
        json.encode({"emp_id": loginResponseModel.value.data?[0].id ?? ""});
    request.headers.addAll(headers);

    try{

    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    isLoading.value = false;

    printData("getLeaveListAPI code main ", response.statusCode.toString());

    printData("getLeaveListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "getLeaveListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        LeaveListModel leaveListModel = LeaveListModel.fromJson(userModel);
        leaveList.value = leaveListModel.data ?? [];
      });
    } else if (response.statusCode == 401) {
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
            getLeaveListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            getLeaveListAPI(); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }

  }

  /// delete leave api call
  callDeleteLeaveAPI(String id) async {
    isLoading.value = true;

    String url = urlBase + urlLeaveDelete;

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'BeeyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJtb2JpbGUiOiI5NzM3Mzg4Nzg2IiwiZW1haWwiOiJhZG1pbkBmaXRuZXNzdHJhY2tneW0uY29tIn0.2Givt7c-Wtarer Z1h92xEoyrheqvcBsiMd9j6E8qCpCYwpw',
    //
    // };

    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "id": id,
    });
    request.headers.addAll(headers);

    printData("boddyyy", request.body);

    try{
    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    isLoading.value = false;

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callDeleteLeaveAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status ?? false) {

          Get.snackbar("Delete", baseModel.message??"");
          getLeaveListAPI();
        } else {
          Get.snackbar("Error", baseModel.message??"");
        }
      });
    } else if (response.statusCode == 401) {
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
            callDeleteLeaveAPI(id); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } on TimeoutException catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Timeout error: ${e.message}");

      /// Show full-screen dialog for time out
      Get.dialog(
        TimeoutDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            callDeleteLeaveAPI(id); // Retry API call
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      isLoading.value = false;
      printData(runtimeType.toString(), "Unexpected error: $e");
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }

  }

  /// delete date api call
  callDeleteDateLeaveAPI(String id, int position) async {

    isLoading.value = true;

    String url = urlBase + urlLeaveDeleteDate;

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'BeeyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJtb2JpbGUiOiI5NzM3Mzg4Nzg2IiwiZW1haWwiOiJhZG1pbkBmaXRuZXNzdHJhY2tneW0uY29tIn0.2Givt7c-Wtarer Z1h92xEoyrheqvcBsiMd9j6E8qCpCYwpw',
    //
    // };

    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "id": id,
    });
    request.headers.addAll(headers);

    printData("boddyyy", request.body);

    try{
    http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          isLoading.value = false;
          throw TimeoutException('The connection has timed out, Please try again!');
        },
      );

    isLoading.value = false;

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callDeleteLeaveAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status ?? false) {

          Get.snackbar("Delete", baseModel.message??"");
          leaveRequestDataList.removeAt(position);
          update();
        } else {
          Get.snackbar("Error", baseModel.message??"");
        }
      });
    } else if (response.statusCode == 401) {
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
    callDeleteDateLeaveAPI(id, position); // Retry API call
    },
    ),
    barrierDismissible: false,
    );
    } on TimeoutException catch (e) {
    isLoading.value = false;
    printData(runtimeType.toString(), "Timeout error: ${e.message}");

    /// Show full-screen dialog for time out
    Get.dialog(
    TimeoutDialog(
    onRetry: () {
    Get.back(); // Close the dialog
    callDeleteDateLeaveAPI(id, position); // Retry API call
    },
    ),
    barrierDismissible: false,
    );
    } catch (e) {
    isLoading.value = false;
    printData(runtimeType.toString(), "Unexpected error: $e");
    // Handle other exceptions
    Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<LeaveManagementController>();
  }
}
