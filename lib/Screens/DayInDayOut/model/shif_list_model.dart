// To parse this JSON data, do
//
//     final shiftListModel = shiftListModelFromJson(jsonString);

import 'dart:convert';

ShiftListModel shiftListModelFromJson(String str) => ShiftListModel.fromJson(json.decode(str));

String shiftListModelToJson(ShiftListModel data) => json.encode(data.toJson());

class ShiftListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<ShiftData>? data;

  ShiftListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory ShiftListModel.fromJson(Map<String, dynamic> json) => ShiftListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<ShiftData>.from(json["data"]!.map((x) => ShiftData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ShiftData {
  String? id;
  String? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;
  int? status;

  ShiftData({
    this.id,
    this.shiftId,
    this.shiftName,
    this.startTime,
    this.endTime,
    this.status,
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) => ShiftData(
    id: json["id"],
    shiftId: json["shift_id"],
    shiftName: json["shift_name"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shift_id": shiftId,
    "shift_name": shiftName,
    "start_time": startTime,
    "end_time": endTime,
    "status": status,
  };
}
