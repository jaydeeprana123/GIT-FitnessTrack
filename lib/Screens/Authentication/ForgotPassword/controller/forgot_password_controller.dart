import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../utils/preference_utils.dart';
import '../../../../utils/share_predata.dart';



/// Controller
class ForgotPasswordController extends GetxController {

  Rx<TextEditingController> emailEditingController =
      TextEditingController().obs;


  Rx<TextEditingController> otpText = TextEditingController().obs;

  /// Forgot Password api call
  callForgotPasswordAPI(BuildContext context) async {
     onLoading(context, "Loading..");

    String url = urlBase + urlForgotPassword;

    var headers = {'Content-Type': 'application/json',
      'lang': ( MySharedPrefNew().getString(SharePreData.keyLanguage)).toString()};
    var request = http.Request(
        'POST', Uri.parse(url));
    request.body = json.encode({
      "email": emailEditingController.value.text,

    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

     Navigator.pop(context);

    if (response.statusCode == 200) {

      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(),"forgot password API value ${valueData}");

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

    printData("onClose", "onClose Forgot controller");
    Get.delete<ForgotPasswordController>();
  }



}

