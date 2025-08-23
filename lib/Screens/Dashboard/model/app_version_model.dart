// To parse this JSON data, do
//
//     final appVersionModel = appVersionModelFromJson(jsonString);

import 'dart:convert';

AppVersionModel appVersionModelFromJson(String str) => AppVersionModel.fromJson(json.decode(str));

String appVersionModelToJson(AppVersionModel data) => json.encode(data.toJson());

class AppVersionModel {
  bool? status;
  String? message;
  String? accessToken;
  List<AppVersionData>? data;

  AppVersionModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) => AppVersionModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<AppVersionData>.from(json["data"]!.map((x) => AppVersionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AppVersionData {
  String? id;
  String? iosVersion;
  String? androidVersion;
  String? isForceUpdate;

  AppVersionData({
    this.id,
    this.iosVersion,
    this.androidVersion,
    this.isForceUpdate,
  });

  factory AppVersionData.fromJson(Map<String, dynamic> json) => AppVersionData(
    id: json["id"],
    iosVersion: json["ios_version"],
    androidVersion: json["android_version"],
    isForceUpdate: json["is_force_update"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ios_version": iosVersion,
    "android_version": androidVersion,
    "is_force_update": isForceUpdate,
  };
}
