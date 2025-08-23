import 'dart:convert';

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
import '../model/measurement_list_model.dart';


/// Controller
class MeasurementController extends GetxController {


  RxList<MeasurementData> measurementList = <MeasurementData>[].obs;
  Rx<MeasurementData> selectedMeasurementData = MeasurementData().obs;

  Rx<CustomerLoginResponseModel> loginResponseModel = CustomerLoginResponseModel().obs;

  RxBool measurementListApiCall = false.obs;
  getUserInfo() async{
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref().getCustomerLoginModel(SharePreData.keySaveLoginModel))??CustomerLoginResponseModel();
  }

  /// get measurement list
  getAllMeasurementListAPI(BuildContext context) async {
    measurementListApiCall.value = false;

    String url = urlBase + urlMeasurementList;

    printData("urrllll", url);

    String token = await MySharedPref().getStringValue(SharePreData.keyAccessToken);
    printData("tokenn", token);

    var headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'};

    //
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

    measurementListApiCall.value = true;

    printData("getAllMeasurementListAPI code main ", response.statusCode.toString());

    printData("getAllMeasurementListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getAllMeasurementListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        MeasurementListModel measurementListModel = MeasurementListModel.fromJson(userModel);
        measurementList.value = measurementListModel.data ?? [];
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
    Get.delete<MeasurementController>();
  }
}
