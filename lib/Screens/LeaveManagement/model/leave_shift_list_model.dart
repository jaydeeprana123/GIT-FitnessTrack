// To parse this JSON data, do
//
//     final leaveShiftListModel = leaveShiftListModelFromJson(jsonString);

import 'dart:convert';

LeaveShiftListModel leaveShiftListModelFromJson(String str) => LeaveShiftListModel.fromJson(json.decode(str));

String leaveShiftListModelToJson(LeaveShiftListModel data) => json.encode(data.toJson());

class LeaveShiftListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<LeaveShiftData>? data;

  LeaveShiftListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory LeaveShiftListModel.fromJson(Map<String, dynamic> json) => LeaveShiftListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<LeaveShiftData>.from(json["data"]!.map((x) => LeaveShiftData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LeaveShiftData {
  String? id;
  String? name;

  LeaveShiftData({
    this.id,
    this.name,
  });

  factory LeaveShiftData.fromJson(Map<String, dynamic> json) => LeaveShiftData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
