import 'dart:convert';
import 'dart:io';

import 'package:fitness_track/Screens/Authentication/Profile/model/area_list_model.dart';
import 'package:fitness_track/Screens/Authentication/Profile/model/city_list_model.dart';
import 'package:fitness_track/Screens/Authentication/Profile/model/state_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/api_response.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../Authentication/Login/model/customer_login_response_model.dart';

/// Controller
class CustomerProfileController extends GetxController {
  /// Editing controller for text field
  Rx<int> male = (-1).obs;
  RxList<StateData> stateList = <StateData>[].obs;
  RxList<CityData> cityList = <CityData>[].obs;
  RxList<AreaData> areaList = <AreaData>[].obs;

  String? deviceToken;

  RxString imagePathOfProfile = "".obs;

  /// Editing controller for text field
  Rx<TextEditingController> userNameEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> nameEditingController = TextEditingController().obs;
  Rx<TextEditingController> mobileNoEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> emailEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> clientCodeEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> dobEditingController = TextEditingController().obs;
  Rx<TextEditingController> occupationEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> emergencyPersonNameEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> emergencyPersonPhoneEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> problemEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> medicineEditingController =
      TextEditingController().obs;

  /// Editing controller for text field
  Rx<TextEditingController> passwordEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> repeatPasswordEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> aadharCardNoEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> branchIdEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> addressEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> areaEditingController = TextEditingController().obs;
  Rx<TextEditingController> pinCodeEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> ageEditingController = TextEditingController().obs;
  Rx<TextEditingController> genderEditingController =
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

  Rx<CustomerLoginResponseModel> loginResponseModel =
      CustomerLoginResponseModel().obs;

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref()
            .getCustomerLoginModel(SharePreData.keySaveLoginModel)) ??
        CustomerLoginResponseModel();
    nameEditingController.value.text =
        loginResponseModel.value.data?[0].name ?? "";
    emailEditingController.value.text =
        loginResponseModel.value.data?[0].email ?? "";
    mobileNoEditingController.value.text =
        loginResponseModel.value.data?[0].mobile ?? "";
    //  basicSalaryEditingController.value.text = loginResponseModel.value.data?[0].basicSalary??"";
  }

  // /// Edit profile api call
  // callEditProfileUpAPI(BuildContext context) async {
  //   // onLoading(context, "Loading..");
  //
  //   String url = urlBase + urlRegistration;
  //
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'POST', Uri.parse(url));
  //   request.body = json.encode({
  //     "name": nameEditingController.value.text,
  //   //  "password": passwordEditingController.value.text,
  //     "email": emailEditingController.value.text,
  //     "mobile": mobileNoEditingController.value.text
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //
  //     await response.stream.bytesToString().then((valueData) async {
  //       printData(runtimeType.toString(),"callEditProfileUpAPI API value ${valueData}");
  //
  //       Map<String, dynamic> userModel = json.decode(valueData);
  //       BaseModel model = BaseModel.fromJson(userModel);
  //
  //       if (model.status??false) {
  //         printData(runtimeType.toString(),"callEditProfileUpAPI Message ${model.message}");
  //         snackBar(context, model.message??"");
  //       } else {
  //         snackBar(context, model.message??"");
  //       }
  //     });
  //
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  /// Get profile api
  callGetProfileUpAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlGetCustomerProfileDetails;

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

    var request = http.Request('GET', Uri.parse(url));
    request.body = json.encode({
      "client_id": loginResponseModel.value.data?[0].id ?? "",
    });
    request.headers.addAll(headers);

    printData("request", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    printData("response status code", response.statusCode.toString());
    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callGetProfileUpAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        loginResponseModel.value =
            CustomerLoginResponseModel.fromJson(userModel);

        if (loginResponseModel.value.status ?? false) {
          /// Set login model into shared preference
          MySharedPref().setCustomerLoginModel(
              loginResponseModel.value, SharePreData.keySaveLoginModel);
          userNameEditingController.value.text =
              loginResponseModel.value.data?[0].username ?? "";
          nameEditingController.value.text =
              loginResponseModel.value.data?[0].name ?? "";
          clientCodeEditingController.value.text =
              loginResponseModel.value.data?[0].clientCode ?? "";
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
          ageEditingController.value.text =
              loginResponseModel.value.data?[0].age ?? "";


          printData("gender", (loginResponseModel.value.data?[0].gender ?? ""));

          if ((loginResponseModel.value.data?[0].gender ?? "").toLowerCase() ==
              "1") {
            male.value = 1;
            genderEditingController.value.text = "Male";
          } else if ((loginResponseModel.value.data?[0].gender ?? "")
                  .toLowerCase() ==
              "2") {
            male.value = 2;

            genderEditingController.value.text = "Female";
          } else {
            male.value = 3;

            genderEditingController.value.text = "Others";
          }

          dobEditingController.value.text =
              loginResponseModel.value.data?[0].dob ?? "";
          occupationEditingController.value.text =
              loginResponseModel.value.data?[0].occupation ?? "";
          emergencyPersonNameEditingController.value.text =
              loginResponseModel.value.data?[0].emergencyPersonName ?? "";
          emergencyPersonPhoneEditingController.value.text =
              loginResponseModel.value.data?[0].emergencyPersonPhone ?? "";
          problemEditingController.value.text =
              loginResponseModel.value.data?[0].problem ?? "";
          medicineEditingController.value.text =
              loginResponseModel.value.data?[0].medicine ?? "";
          aadharCardNoEditingController.value.text =
              loginResponseModel.value.data?[0].aadharCardNo ?? "";
          branchIdEditingController.value.text =
              loginResponseModel.value.data?[0].branchId ?? "";
        } else {
          snackBar(context, loginResponseModel.value.message ?? "");
        }
      });
    } else {
      print("kjhkj" + (response.reasonPhrase).toString());
    }
  }

  /// edit profile api
  callEditProfileUpAPI(BuildContext context, String stateId, String cityId,
      String areaId) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlEditCustomerProfileDetails;
    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['authorization'] = 'Bearer $token';

    request.fields.addAll({
      "client_id": loginResponseModel.value.data?[0].id ?? "",
      "client_code": loginResponseModel.value.data?[0].clientCode ?? "",
      "branch_id": loginResponseModel.value.data?[0].branchId ?? "",
      "trainer_id": loginResponseModel.value.data?[0].trainerId ?? "",
      "programme_id": loginResponseModel.value.data?[0].programmeId ?? "",
      "aadhar_card_no": aadharCardNoEditingController.value.text,
      "name": nameEditingController.value.text,
      "age": ageEditingController.value.text,
      "gender": male.value == 0 ? "m" : "f",
      "mobile": mobileNoEditingController.value.text,
      "dob": dobEditingController.value.text,
      "email": emailEditingController.value.text,
      "signature": "Yes",
      "address": addressEditingController.value.text,
      "city_id": cityId,
      "state_id": stateId,
      "area_id": areaId,
      "pincode": pinCodeEditingController.value.text,
      "occupation": occupationEditingController.value.text,
      "username": userNameEditingController.value.text,
      "emergency_person_name": emergencyPersonNameEditingController.value.text,
      "emergency_person_phone":
          emergencyPersonPhoneEditingController.value.text,
      "problem": problemEditingController.value.text,
      "medicine": medicineEditingController.value.text,
      "status": "0"
    });

    if (imagePathOfProfile.value.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', imagePathOfProfile.value));
    }

    printData("request of edit profile", request.fields.toString());

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),
            "callEditProfileUpAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        CustomerLoginResponseModel loginResponseModel =
            CustomerLoginResponseModel.fromJson(userModel);

        imagePathOfProfile.value = "";

        if (loginResponseModel.status ?? false) {
          /// Set login model into shared preference
          MySharedPref().setCustomerLoginModel(
              loginResponseModel, SharePreData.keySaveLoginModel);
          printData(runtimeType.toString(),
              "callEditProfileUpAPI Message ${loginResponseModel.message}");

          Navigator.pop(context);
          snackBar(context, loginResponseModel.message ?? "");
        } else {
          // Navigator.pop(context);
          snackBar(context, loginResponseModel.message ?? "");
        }
      });
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
    // http.StreamedResponse response = await request.send();
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

  /// change password api
  callChangePasswordAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlChangePassword;

    var headers = {
      'Content-Type': 'application/json',
      'lang': (await MySharedPref().getStringValue(SharePreData.keyLanguage))
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

    http.StreamedResponse response = await request.send();

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
    // http.StreamedResponse response = await request.send();
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
  getStateList(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlStateList;

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
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

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getStateList value ${valueData}");

        Map<String, dynamic> mapModel = json.decode(valueData);
        StateListModel stateListModel = StateListModel.fromJson(mapModel);
        stateList.value = stateListModel.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// get city list api call
  getCityList(BuildContext context, String stateId) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlCityList;

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
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

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getCityList value ${valueData}");

        Map<String, dynamic> mapModel = json.decode(valueData);
        CityListModel cityListModel = CityListModel.fromJson(mapModel);
        cityList.value = cityListModel.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// get area list api call
  getAreaList(BuildContext context, String cityId) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlAreaList;

    String token =
        await MySharedPref().getStringValue(SharePreData.keyAccessToken);
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

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getAreaList value ${valueData}");

        Map<String, dynamic> mapModel = json.decode(valueData);
        AreaListModel areaListModel = AreaListModel.fromJson(mapModel);
        areaList.value = areaListModel.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<CustomerProfileController>();
  }
}
