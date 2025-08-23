// To parse this JSON data, do
//
//     final appointmentListModel = appointmentListModelFromJson(jsonString);

import 'dart:convert';

AppointmentListModel appointmentListModelFromJson(String str) => AppointmentListModel.fromJson(json.decode(str));

String appointmentListModelToJson(AppointmentListModel data) => json.encode(data.toJson());

class AppointmentListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<AppointmentData>? data;

  AppointmentListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory AppointmentListModel.fromJson(Map<String, dynamic> json) => AppointmentListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<AppointmentData>.from(json["data"]!.map((x) => AppointmentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AppointmentData {
  String? id;
  String? date;
  String? time;
  String? approveStatus;
  String? remarks;
  String? status;
  String? deleteStatus;

  AppointmentData({
    this.id,
    this.date,
    this.time,
    this.approveStatus,
    this.remarks,
    this.status,
    this.deleteStatus,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) => AppointmentData(
    id: json["id"],
    date: json["date"],
    time: json["time"],
    approveStatus: json["approve_status"],
    remarks: json["remarks"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time": time,
    "approve_status": approveStatus,
    "remarks": remarks,
    "status": status,
    "delete_status": deleteStatus,
  };
}
