import 'dart:convert';
import 'package:fitness_track/Screens/Authentication/Login/view/employee_login_via_otp_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_track/Styles/my_icons.dart';

import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Networks/api_endpoint.dart';
import '../../../../Networks/model/base_model.dart';
import '../../../../Utils/preference_utils.dart';
import '../../../../Utils/share_predata.dart';
import '../../../Authentication/Login/model/customer_login_response_model.dart';



class CusteomerBottomNavigationController extends GetxController {

  RxInt currentIndex = 0.obs;

  List<String> myAccountList = [
    "My Profile",
    "My Favourite",
    "My Notifications",
  ];

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

  Rx<CustomerLoginResponseModel> loginResponseModel = CustomerLoginResponseModel().obs;
  RxString daily = "Daily".obs;

  @override
  void onInit() {
   // currentIndex.value = HomeTabEnum.Home.index;
    super.onInit();
  }

  getUserInfo() async {
    /// Set login model into shared preference
    loginResponseModel.value =
        await MySharedPref().getCustomerLoginModel(SharePreData.keySaveLoginModel)??CustomerLoginResponseModel();
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

    http.StreamedResponse response = await request.send();

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


  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   printData("onClose", "onClose bottom navigation controller");
  //   Get.delete<BottomNavigationController>();
  // }



}
