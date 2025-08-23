import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_track/Screens/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../Networks/api_endpoint.dart';
import '../Networks/api_response.dart';
import '../Networks/model/base_model.dart';
import '../Utils/share_predata.dart';
import '../utils/preference_utils.dart';
import 'LocalNotificationService.dart';

class PushNotificationsService {
  PushNotificationsService._();

  factory PushNotificationsService() => _instance;

  static final PushNotificationsService _instance =
      PushNotificationsService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _initialized = false;

  // BuildContext _context;

  Future<void> init() async {
    // _context = context;
    if (!_initialized) {
      // For iOS request permission first.

      await _firebaseMessaging.requestPermission();
      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler);

      _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
        print("FirebaseMessaging.getInitialMessage");
        if (message != null) {
          LocalNotificationService.displayNotification(message, "");

        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage event) async {

        LocalNotificationService.displayNotification(event, "");
        // Fluttertoast.showToast(
        //     msg: "onMessage",
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );

        print("message recieved");
        print("message title ${event.notification?.title ?? ""}");
        print("message body ${event.notification?.body ?? ""}");
        print("event.data -- > ${event.data}");


      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) async{

      });

      // For testing purposes print the Firebase Messaging token
      var preferences = MySharedPref();
      String? fcmToken = await _firebaseMessaging.getToken();

      print("FCM Token $fcmToken");

      _initialized = true;
    }
  }


// getTokenForVideoAudioCall(CallNotificationModel callNotificationModel) async {
//   //  onLoading(context, "Loading..");
//
//   print("getTokenForVideoAudioCall");
//   var preferences = MySharedPref();
//   String token = await preferences.getStringValue(SharePreData.keyToken);
//
//  var loginModel =
//   await preferences.getEmployeeLoginModel(SharePreData.keySaveLoginModel);
//
//   String url = urlBase + urlTokenForVideoAudioCall;
//
//
//
//   dynamic body = {
//     'user_id':  (loginModel?.data?.id??0).toString(),
//     'channel_name': callNotificationModel.channelName??"",
//   };
//
//   final apiReq = Request();
//
//   await apiReq.postAPI(url, body, token).then((value) async {
//     http.StreamedResponse res = value;
//
//     printData("Edit member status code", value.statusCode.toString());
//     // Navigator.pop(context);
//     if (res.statusCode == 200) {
//       await res.stream.bytesToString().then((value) async {
//         Map<String, dynamic> userModel = json.decode(value);
//         BaseModel model = BaseModel.fromJson(userModel);
//
//         if (model.statusCode == 200) {
//           AgoraTokenModel agoraTokenModel =
//           AgoraTokenModel.fromJson(userModel);
//
//           print('agora token ' + agoraTokenModel.data!);
//
//           var bookingDetails = BookingDetails();
//           bookingDetails.doctorId = int.parse(callNotificationModel.userId??"0");
//           bookingDetails.id = int.parse(callNotificationModel.bookingId??"0");
//           bookingDetails.doctorName = callNotificationModel.userName??"";
//           if (int.parse(callNotificationModel.incommingCallType??"0") == CallingTypeEnum.Audio.index) {
//
//
//             Get.to(JoinChannelAudio(
//               doctorId: int.parse(callNotificationModel.agoraUserId??"0"),
//               isCallInitialize: false,
//               doctorName: callNotificationModel.userName ?? "",
//               channelName: callNotificationModel.channelName??"",
//               token: agoraTokenModel.data!,
//               bookingDetails: bookingDetails,
//               documentIdOfTheUserList: callNotificationModel.chatId??"",
//             ))?.then((value) {
//
//             });
//           } else if (int.parse(callNotificationModel.incommingCallType??"0") == CallingTypeEnum.Video.index) {
//             Get.to(JoinChannelVideo(
//               doctorId: int.parse(callNotificationModel.agoraUserId??"0"),
//               isCallInitialize: false,
//               doctorName: callNotificationModel.userName ?? "",
//               channelName: callNotificationModel.channelName??"",
//               token: agoraTokenModel.data!,
//               bookingDetails: bookingDetails,
//               documentIdOfTheUserList: callNotificationModel.chatId??"",
//             ))?.then((value) {
//               print("value from video call " + value.toString());
//
//             });
//           }
//         } else if (model.statusCode == 500) {
//           // logoutFromTheApp(context);
//         } else {
//           // Navigator.pop(context);
//           // snackBar(context, model.message.toString());
//         }
//       });
//     } else {
//       // Navigator.pop(context);
//       // snackBar(context, res.reasonPhrase.toString());
//     }
//   });
// }

}
