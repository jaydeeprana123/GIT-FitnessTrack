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
import '../model/notification_list_model.dart';


/// Controller
class NotificationController extends GetxController {


  RxList<NotificationData> notificationList = <NotificationData>[].obs;

  /// get rating list
  getAllNotificationListAPI(BuildContext context) async {
    onLoading(context, "Loading..");

    String url = urlBase + urlNotificationList;

    printData("urrllll", url);

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(url));


    //
    // request.body = json.encode({
    //   "favorites_id": "1"
    // });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    Navigator.pop(context);

    printData("getAllNotificationListAPI code main ", response.statusCode.toString());

    printData("getAllNotificationListAPI request.body ", request.body);

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((valueData) async {
        printData(runtimeType.toString(), "getAllNotificationListAPI place API value ${valueData}");

        Map<String, dynamic> userModel = json.decode(valueData);
        NotificationListModel notificationListModel = NotificationListModel.fromJson(userModel);
        notificationList.value = notificationListModel.data ?? [];

        notificationList.value.add(notificationList[0]);
        notificationList.value.add(notificationList[0]);
        notificationList.value.add(notificationList[0]);
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
    Get.delete<NotificationController>();
  }
}
