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
import '../../../Styles/my_colors.dart';
import '../model/about_us_model.dart';


/// Controller
class CMSController extends GetxController {

  Rx<AboutUsData> aboutUsData = AboutUsData().obs;

  /// get Fav Category list
  getCMSPageAPI(BuildContext context, String pageName) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlCMSPage;

    printData("urrllll", url);

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(url));

    request.body = json.encode({
      "page_name": pageName
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    printData("getCMSPageAPI code main ", response.statusCode.toString());

    printData("getCMSPageAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getCMSPageAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        AboutUsModel aboutUsModel = AboutUsModel.fromJson(userModel);
        if((aboutUsModel.data??[]).isNotEmpty){
          aboutUsData.value = aboutUsModel.data?[0]??AboutUsData();
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
    Get.delete<CMSController>();
  }
}
