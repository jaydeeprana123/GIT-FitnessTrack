import 'dart:convert';

import 'package:fitness_track/Screens/Customer/Appointment/model/appointment_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_track/Screens/Authentication/Login/model/employee_login_response_model.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../Authentication/Login/model/customer_login_response_model.dart';


/// Controller
class AppointmentController extends GetxController {

  Rx<TextEditingController> remarksEditingController = TextEditingController().obs;
  Rx<TextEditingController> dateEditingController = TextEditingController().obs;
  Rx<TextEditingController> timeksEditingController = TextEditingController().obs;
  RxList<AppointmentData> appointmentList = <AppointmentData>[].obs;
  Rx<AppointmentData> selectedAppointmentData = AppointmentData().obs;

  Rx<CustomerLoginResponseModel> loginResponseModel = CustomerLoginResponseModel().obs;


  getUserInfo() async{
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPrefNew().getCustomerLoginModel(SharePreData.keySaveLoginModel))??CustomerLoginResponseModel();
  }

  /// get measurement list
  getAllAppointmentListAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlAppointmentList;

    printData("urrllll", url);

    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};


    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJtb2JpbGUiOiI5NzM3Mzg4Nzg2IiwiZW1haWwiOiJhZG1pbkBmaXRuZXNzdHJhY2tneW0uY29tIn0.2Givt7c-WtZ1h92xEoyrheqvcBsiMd9j6E8qCpCYwpw',
    //
    // };

    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "customer_id": loginResponseModel.value.data?[0].id??""
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    printData("getAllAppointmentListAPI code main ", response.statusCode.toString());

    printData("getAllAppointmentListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getAllAppointmentListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        AppointmentListModel appointmentListModel = AppointmentListModel.fromJson(userModel);
        appointmentList.value = appointmentListModel.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  /// Insert appointment api call
  callBookAppointmentAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlBookAppointment;
    printData("callBookAppointmentAPI url", url);
    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};
    var request = http.Request(
        'POST', Uri.parse(url));


    printData("callBookAppointmentAPI headers", headers.toString());


    request.body = json.encode({
      "login_id": loginResponseModel.value.data?[0].id??"0",
      "date": dateEditingController.value.text,
      "time": timeksEditingController.value.text,
      "approve_status": "0",
      "branch_id": loginResponseModel.value.data?[0].branchId??"0",
      "remarks": remarksEditingController.value.text,
    });
    request.headers.addAll(headers);

    printData("callBookAppointmentAPI boddyyy", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {

      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),"callInsertFavCommentAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status??false) {
          snackBar(context, baseModel.message??"");

          Navigator.pop(context);

        } else {
          snackBar(context, baseModel.message??"");
        }
      });

    } else {
      print(response.reasonPhrase);
    }
  }


  /// delete appointment api call
  callDeleteAppointmentAPI(BuildContext context, String id) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlDeleteAppointment;

    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};


    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'BeeyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJtb2JpbGUiOiI5NzM3Mzg4Nzg2IiwiZW1haWwiOiJhZG1pbkBmaXRuZXNzdHJhY2tneW0uY29tIn0.2Givt7c-Wtarer Z1h92xEoyrheqvcBsiMd9j6E8qCpCYwpw',
    //
    // };

    var request = http.Request(
        'POST', Uri.parse(url));
    request.body = json.encode({
      "id": id,
    });
    request.headers.addAll(headers);

    printData("boddyyy", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {

      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),"callInsertFavCommentAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status??false) {
          snackBar(context, baseModel.message??"");

          getAllAppointmentListAPI(context);

        } else {
          snackBar(context, baseModel.message??"");
        }
      });

    } else {
      print(response.reasonPhrase);
    }
  }


  /// Update appointment api call
  callUpdateAppointmentAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlUpdateAppointment;

    String token = await MySharedPrefNew().getString(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};


    var request = http.Request(
        'POST', Uri.parse(url));
    request.body = json.encode({
      "id": selectedAppointmentData.value.id??"",
      "date": dateEditingController.value.text,
      "time": timeksEditingController.value.text,
      "approve_status": "0",
      "branch_id": loginResponseModel.value.data?[0].branchId??"0",
      "remarks": remarksEditingController.value.text,
      "status":"0"
    });
    request.headers.addAll(headers);

    printData("boddyyy", request.body);

    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    if (response.statusCode == 200) {

      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),"callInsertFavCommentAPI API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        BaseModel baseModel = BaseModel.fromJson(userModel);

        if (baseModel.status??false) {
          snackBar(context, baseModel.message??"");

          Navigator.pop(context);

        } else {
          snackBar(context, baseModel.message??"");
        }
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
    Get.delete<AppointmentController>();
  }
}
