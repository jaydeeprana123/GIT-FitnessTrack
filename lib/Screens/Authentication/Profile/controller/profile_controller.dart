import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitness_track/Screens/Authentication/Profile/model/area_list_model.dart';
import 'package:fitness_track/Screens/Authentication/Profile/model/city_list_model.dart';
import 'package:fitness_track/Screens/Authentication/Profile/model/state_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../CommonWidgets/internet_connection_dialog.dart';
import '../../../../CommonWidgets/time_out_dialog.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/api_response.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../Login/model/employee_login_response_model.dart';

/// Controller
class ProfileController extends GetxController {
  /// Editing controller for text field

  RxList<StateData> stateList = <StateData>[].obs;
  RxList<CityData> cityList = <CityData>[].obs;
  RxList<AreaData> areaList = <AreaData>[].obs;
  Rx<TextEditingController> employeeCodeEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> mobileNoEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> emailEditingController =
      TextEditingController().obs;

  /// Editing controller for text field
  Rx<TextEditingController> passwordEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> repeatPasswordEditingController =
      TextEditingController().obs;

  String? deviceToken;

  Rx<TextEditingController> nameEditingController = TextEditingController().obs;

  RxString imagePathOfProfile = "".obs;
  RxString imagePathOfAadharCard = "".obs;
  RxString imagePathOfOldCancelledCheque = "".obs;

  /// Editing controller for text field
  Rx<TextEditingController> basicSalaryEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> sundayAmountEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> overtimeAmountEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> personalTrainingAmountEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> absentAmountEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> lateMinAmountEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> currentShiftEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> joiningDateEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> bankAccountNumberEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> bankNameEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> ifscCodeEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> accountTypeEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> upiIdEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> termConditionEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> aadharCardNoEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> designationIdEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> designationNameEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> branchIdEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> addressEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> areaEditingController = TextEditingController().obs;
  Rx<TextEditingController> pinCodeEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> remarksEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> cityEditingController = TextEditingController().obs;
  Rx<TextEditingController> stateEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> oldPasswordEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> newPasswordEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> otpText = TextEditingController().obs;

  Rx<EmployeeLoginResponseModel> loginResponseModel =
      EmployeeLoginResponseModel().obs;
  RxBool isLoading = false.obs;

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPrefNew()
            .getEmployeeLoginModel(SharePreData.keySaveLoginModel)) ??
        EmployeeLoginResponseModel();

    nameEditingController.value.text =
        loginResponseModel.value.data?[0].name ?? "";
    emailEditingController.value.text =
        loginResponseModel.value.data?[0].email ?? "";
    mobileNoEditingController.value.text =
        loginResponseModel.value.data?[0].mobile ?? "";
    basicSalaryEditingController.value.text =
        loginResponseModel.value.data?[0].basicSalary ?? "";
  }

  /// Get profile api
  callGetProfileUpAPI() async {
    isLoading.value = true;

    String url = urlBase + urlGetProfileDetails;

    String token =
        await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData(url, url);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "customer_id": loginResponseModel.value.data?[0].id ?? "",
    });
    request.headers.addAll(headers);

    printData("request", request.body);

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

      printData("response status code", response.statusCode.toString());
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "callGetProfileUpAPI API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          loginResponseModel.value =
              EmployeeLoginResponseModel.fromJson(userModel);

          if (loginResponseModel.value.status ?? false) {
            /// Set login model into shared preference
            MySharedPrefNew().setEmployeeLoginModel(
                loginResponseModel.value, SharePreData.keySaveLoginModel);

            nameEditingController.value.text =
                loginResponseModel.value.data?[0].name ?? "";
            employeeCodeEditingController.value.text =
                loginResponseModel.value.data?[0].empCode ?? "";
            emailEditingController.value.text =
                loginResponseModel.value.data?[0].email ?? "";
            mobileNoEditingController.value.text =
                loginResponseModel.value.data?[0].mobile ?? "";
            cityEditingController.value.text =
                loginResponseModel.value.data?[0].cityName ?? "";
            stateEditingController.value.text =
                loginResponseModel.value.data?[0].stateName ?? "";
            areaEditingController.value.text =
                loginResponseModel.value.data?[0].areaName ?? "";
            pinCodeEditingController.value.text =
                loginResponseModel.value.data?[0].pincode ?? "";
            addressEditingController.value.text =
                loginResponseModel.value.data?[0].address ?? "";
            remarksEditingController.value.text =
                loginResponseModel.value.data?[0].remarks ?? "";

            aadharCardNoEditingController.value.text =
                loginResponseModel.value.data?[0].aadharCardNo ?? "";
            designationIdEditingController.value.text =
                loginResponseModel.value.data?[0].designationId ?? "";
            designationNameEditingController.value.text =
                loginResponseModel.value.data?[0].designationName ?? "";

            branchIdEditingController.value.text =
                loginResponseModel.value.data?[0].branchId ?? "";

            basicSalaryEditingController.value.text =
                loginResponseModel.value.data?[0].basicSalary ?? "";
            sundayAmountEditingController.value.text =
                loginResponseModel.value.data?[0].sundayAmt ?? "";
            overtimeAmountEditingController.value.text =
                loginResponseModel.value.data?[0].overTimeAmt ?? "";
            personalTrainingAmountEditingController.value.text =
                loginResponseModel.value.data?[0].personalTrainingAmt ?? "";
            absentAmountEditingController.value.text =
                loginResponseModel.value.data?[0].absentAmt ?? "";
            lateMinAmountEditingController.value.text =
                loginResponseModel.value.data?[0].lateMinAmt ?? "";

            currentShiftEditingController.value.text =
                loginResponseModel.value.data?[0].currentShift ?? "";
            joiningDateEditingController.value.text =
                loginResponseModel.value.data?[0].joiningDate ?? "";

            bankAccountNumberEditingController.value.text =
                loginResponseModel.value.data?[0].bankAccNo ?? "";
            bankNameEditingController.value.text =
                loginResponseModel.value.data?[0].bankName ?? "";
            ifscCodeEditingController.value.text =
                loginResponseModel.value.data?[0].ifscCode ?? "";
            accountTypeEditingController.value.text =
                loginResponseModel.value.data?[0].accountType ?? "";
            upiIdEditingController.value.text =
                loginResponseModel.value.data?[0].upiId ?? "";
          } else {
            Get.snackbar("Error", loginResponseModel.value.message ?? "");
          }
        });
      } else if (response.statusCode == 401) {
        goToWelcomeScreen();
      } else {
        print("kjhkj" + (response.reasonPhrase).toString());
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      printData(runtimeType.toString(), "No internet connection.");

      /// Show full-screen dialog for no internet
      Get.dialog(
        NoInternetDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            callGetProfileUpAPI(); // Retry API call
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
            callGetProfileUpAPI(); // Retry API call
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

  /// edit profile api
  callEditProfileUpAPI(String stateId, String cityId, String areaId) async {
    isLoading.value = true;
    String url = urlBase + urlEditProfileDetails;
    String token =
        await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['authorization'] = 'Bearer $token';

    request.fields.addAll({
      "employee_id": loginResponseModel.value.data?[0].id ?? "",
      "aadhar_card_no": aadharCardNoEditingController.value.text,
      "email": emailEditingController.value.text,
      "signature": "Yes",
      "address": addressEditingController.value.text,
      "city_id": cityId,
      "state_id": stateId,
      "area_id": areaId,
      "pincode": pinCodeEditingController.value.text,
      "bank_acc_no": bankAccountNumberEditingController.value.text,
      "bank_name": bankNameEditingController.value.text,
      "ifsc_code": ifscCodeEditingController.value.text,
      "account_type": accountTypeEditingController.value.text,
      "upi_id": upiIdEditingController.value.text,
      "term_condition": termConditionEditingController.value.text,
      "current_login_id": "1"
    });

    if (imagePathOfProfile.value.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', imagePathOfProfile.value));
    }

    if (imagePathOfAadharCard.value.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'aadhar_card_pic', imagePathOfAadharCard.value));
    }

    if (imagePathOfOldCancelledCheque.value.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'old_cancelled_cheq_photo', imagePathOfOldCancelledCheque.value));
    }

    printData("request of edit profile", request.fields.toString());

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

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(),
              "callEditProfileUpAPI API value ${valueData}");

          Map<String, dynamic> userModel = json.decode(valueData);
          EmployeeLoginResponseModel loginResponseModel =
              EmployeeLoginResponseModel.fromJson(userModel);

          imagePathOfProfile.value = "";
          imagePathOfAadharCard.value = "";
          imagePathOfOldCancelledCheque.value = "";

          if (loginResponseModel.status ?? false) {
            /// Set login model into shared preference
            MySharedPrefNew().setEmployeeLoginModel(
                loginResponseModel, SharePreData.keySaveLoginModel);
            printData(runtimeType.toString(),
                "callEditProfileUpAPI Message ${loginResponseModel.message}");

            Get.back();
            Get.snackbar("Success", loginResponseModel.message ?? "");
          } else {
            Get.snackbar("Error", loginResponseModel.message ?? "");
          }
        });
      } else if (response.statusCode == 401) {
        goToWelcomeScreen();
      } else {
        // Navigator.pop(context);
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
            callEditProfileUpAPI(stateId, cityId, areaId); // Retry API call
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
            callEditProfileUpAPI(stateId, cityId, areaId);
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

  /// change password api
  callChangePasswordAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlChangePassword;

    var headers = {
      'Content-Type': 'application/json',
      'lang': (await MySharedPrefNew().getString(SharePreData.keyLanguage))
          .toString()
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "customer_id": loginResponseModel.value.data?[0].id ?? "",
      "old_password": oldPasswordEditingController.value.text,
      "new_password": newPasswordEditingController.value.text,
      "confirm_password": confirmPasswordEditingController.value.text,
    });
    request.headers.addAll(headers);

    printData("request callChangePasswordAPI", request.body);

    http.StreamedResponse response = await request.send().timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        isLoading.value = false;
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      },
    );

    Navigator.pop(context);
    printData(runtimeType.toString(),
        "callChangePasswordAPI API status ${response.statusCode}");
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callChangePasswordAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);
        if (baseModel.status ?? false) {
          Navigator.pop(context);
          snackBar(context, baseModel.message ?? "");
        } else {
          // Navigator.pop(context);
          snackBar(context, baseModel.message ?? "");
        }
      });
    } else if (response.statusCode == 401) {
      goToWelcomeScreen();
    } else {
      // Navigator.pop(context);
      print(response.reasonPhrase);
    }

    // var headers = {'Content-Type': 'application/json'};
    // var request = http.Request(
    //     'POST', Uri.parse(url));
    // request.body = json.encode({
    //   "customer_id": loginResponseModel?.data?[0].id??"",
    //   "name": nameEditingController.value.text,
    //   "email": emailEditingController.value.text,
    //   "mobile": mobileNoEditingController.value.text,
    //   "dob": "$year-$month-${date}",
    //   "tob": "$hour:$minute",
    //   "pob": nameEditingController.value.text,
    //   "address": address1EditingController.value.text,
    //   "city": cityEditingController.value.text,
    //   "pincode": stateEditingController.value.text,
    //   "country": "India",
    //   "image": "",
    //
    // });
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send().timeout(
    //
    // if (response.statusCode == 200) {
    //
    //   await response.stream.bytesToString().then((valueData) async {
    //     printData(runtimeType.toString(),"callGetProfileUpAPI API value ${valueData}");
    //
    //     Map<String, dynamic> userModel = json.decode(valueData);
    //     BaseModel model = BaseModel.fromJson(userModel);
    //
    //     if (model.status??false) {
    //       printData(runtimeType.toString(),"callGetProfileUpAPI Message ${model.message}");
    //       snackBar(context, model.message??"");
    //     } else {
    //       snackBar(context, model.message??"");
    //     }
    //   });
    //
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  /// get state list api call
  getStateList() async {
    isLoading.value = true;

    String url = urlBase + urlStateList;

    String token =
        await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse(url));

    // request.body = json.encode({
    //   "chat_id": chatId.value,
    // });

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

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(), "getStateList value ${valueData}");

          Map<String, dynamic> mapModel = json.decode(valueData);
          StateListModel stateListModel = StateListModel.fromJson(mapModel);
          stateList.value = stateListModel.data ?? [];
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
            getStateList(); // Retry API call
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
            getStateList(); //
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

  /// get city list api call
  getCityList(String stateId) async {
    isLoading.value = true;

    String url = urlBase + urlCityList;

    String token =
        await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "state_id": stateId,
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

      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((valueData) async {
          printData(runtimeType.toString(), "getCityList value ${valueData}");

          Map<String, dynamic> mapModel = json.decode(valueData);
          CityListModel cityListModel = CityListModel.fromJson(mapModel);
          cityList.value = cityListModel.data ?? [];
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
            getCityList(stateId); // Retry API call
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
            getCityList(stateId); //
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

  /// get area list api call
  getAreaList(String cityId) async {
    isLoading.value = true;

    String url = urlBase + urlAreaList;

    String token =
        await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "city_id": cityId,
    });

    request.headers.addAll(headers);

    try{
    http.StreamedResponse response = await request.send().timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        isLoading.value = false;
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      },
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getAreaList value ${valueData}");

        Map<String, dynamic> mapModel = json.decode(valueData);
        AreaListModel areaListModel = AreaListModel.fromJson(mapModel);
        areaList.value = areaListModel.data ?? [];
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
            getAreaList(cityId); // Retry API call
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
            getAreaList(cityId); //
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
    Get.delete<ProfileController>();
  }
}
