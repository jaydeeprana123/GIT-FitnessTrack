// To parse this JSON data, do
//
//     final attendanceListModel = attendanceListModelFromJson(jsonString);

import 'dart:convert';

AttendanceListModel attendanceListModelFromJson(String str) => AttendanceListModel.fromJson(json.decode(str));

String attendanceListModelToJson(AttendanceListModel data) => json.encode(data.toJson());

class AttendanceListModel {
  bool? status;
  String? message;
  List<AttendanceData>? data;

  AttendanceListModel({
    this.status,
    this.message,
    this.data,
  });

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) => AttendanceListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AttendanceData>.from(json["data"]!.map((x) => AttendanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AttendanceData {
  int? id;
  DateTime? date;
  String? shiftName;
  String? shiftIn;
  String? latePunch;
  String? shiftOut;
  String? overTime;
  String? branchId;
  String? branchName;
  bool? absent;

  AttendanceData({
    this.id,
    this.date,
    this.shiftName,
    this.shiftIn,
    this.latePunch,
    this.shiftOut,
    this.overTime,
     this.branchId,
     this.branchName,
    this.absent,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    shiftName: json["shift_name"],
    shiftIn: json["shift_in"],
    latePunch: json["late_punch"],
    shiftOut: json["shift_out"],
    overTime: json["over_time"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    absent: json["absent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "shift_name": shiftName,
    "shift_in": shiftIn,
    "late_punch": latePunch,
    "shift_out": shiftOut,
    "over_time": overTime,
    "branch_id": branchId,
    "branch_name": branchName,
    "absent": absent,
  };
}
