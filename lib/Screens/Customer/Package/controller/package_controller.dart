import 'dart:convert';

import 'package:fitness_track/Screens/Authentication/Login/model/customer_login_response_model.dart';
import 'package:fitness_track/Screens/Customer/Package/model/package_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_track/Screens/Authentication/Login/model/employee_login_response_model.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';


/// Controller
class PackageController extends GetxController {

  Rx<CustomerLoginResponseModel> loginResponseModel = CustomerLoginResponseModel().obs;

  RxList<PackageData> packageList = <PackageData>[].obs;

  Rx<PackageData> selectedPackage = PackageData().obs;

  /// get user info
  getUserInfo() async{
    /// Set login model into shared preference
    loginResponseModel.value = (await MySharedPref().getCustomerLoginModel(SharePreData.keySaveLoginModel))??CustomerLoginResponseModel();

  }

  /// get package list
  getAllPackageListAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlPackageList;

    printData("urrllll", url);

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(url));

    request.body = json.encode({
      "client_id": "1"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    printData("getAllNotificationListAPI code main ", response.statusCode.toString());

    printData("getAllNotificationListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getAllNotificationListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        PackageListModel packageListModel = PackageListModel.fromJson(userModel);
        packageList.value = packageListModel.data ?? [];
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
    Get.delete<PackageController>();
  }
}
