// To parse this JSON data, do
//
//     final lateEmployeeListModel = lateEmployeeListModelFromJson(jsonString);

import 'dart:convert';

LateEmployeeListModel lateEmployeeListModelFromJson(String str) => LateEmployeeListModel.fromJson(json.decode(str));

String lateEmployeeListModelToJson(LateEmployeeListModel data) => json.encode(data.toJson());

class LateEmployeeListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<LateEmployeeData>? data;

  LateEmployeeListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory LateEmployeeListModel.fromJson(Map<String, dynamic> json) => LateEmployeeListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<LateEmployeeData>.from(json["data"]!.map((x) => LateEmployeeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LateEmployeeData {
  String? id;
  String? empId;
  String? empName;
  String? branchId;
  String? branchName;
  String? shiftId;
  String? shiftName;
  String? selfie;
  DateTime? date;
  String? punchTime;
  String? lateTime;

  LateEmployeeData({
    this.id,
    this.empId,
    this.empName,
    this.branchId,
    this.branchName,
    this.shiftId,
    this.shiftName,
    this.selfie,
    this.date,
    this.punchTime,
    this.lateTime,
  });

  factory LateEmployeeData.fromJson(Map<String, dynamic> json) => LateEmployeeData(
    id: json["id"],
    empId: json["emp_id"],
    empName: json["emp_name"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    shiftId: json["shift_id"],
    shiftName: json["shift_name"],
    selfie: json["selfie"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    punchTime: json["punch_time"],
    lateTime: json["late_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "emp_name": empName,
    "branch_id": branchId,
    "branch_name": branchName,
    "shift_id": shiftId,
    "shift_name": shiftName,
    "selfie": selfie,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "punch_time": punchTime,
    "late_time": lateTime,
  };
}
