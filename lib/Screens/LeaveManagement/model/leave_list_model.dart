// To parse this JSON data, do
//
//     final leaveListModel = leaveListModelFromJson(jsonString);

import 'dart:convert';

LeaveListModel leaveListModelFromJson(String str) => LeaveListModel.fromJson(json.decode(str));

String leaveListModelToJson(LeaveListModel data) => json.encode(data.toJson());

class LeaveListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<LeaveListData>? data;

  LeaveListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory LeaveListModel.fromJson(Map<String, dynamic> json) => LeaveListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<LeaveListData>.from(json["data"]!.map((x) => LeaveListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LeaveListData {
  String? id;
  String? empId;
  String? branchId;
  String? branchName;
  String? leaveCategoryId;
  String? leaveCategoryName;
  dynamic leaveDate;
  String? totalDays;
  String? totalShift;
  String? remarks;
  String? leaveStatusType;
  String? leaveStatus;
  String? personRemark;
  List<LeaveDataList>? leaveDataList;

  LeaveListData({
    this.id,
    this.empId,
    this.branchId,
    this.branchName,
    this.leaveCategoryId,
    this.leaveCategoryName,
    this.leaveDate,
    this.totalDays,
    this.totalShift,
    this.remarks,
    this.leaveStatusType,
    this.leaveStatus,
    this.personRemark,
    this.leaveDataList,
  });

  factory LeaveListData.fromJson(Map<String, dynamic> json) => LeaveListData(
    id: json["id"],
    empId: json["emp_id"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    leaveCategoryId: json["leave_category_id"],
    leaveCategoryName: json["leave_category_name"],
    leaveDate: json["leave_date"],
    totalDays: json["total_days"],
    totalShift: json["total_shift"],
    remarks: json["remarks"],
    leaveStatusType: json["leave_status_type"],
    leaveStatus: json["leave_status"],
    personRemark: json["person_remark"],
    leaveDataList: json["leave_data_list"] == null ? [] : List<LeaveDataList>.from(json["leave_data_list"]!.map((x) => LeaveDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "branch_id": branchId,
    "branch_name": branchName,
    "leave_category_id": leaveCategoryId,
    "leave_category_name": leaveCategoryName,
    "leave_date": leaveDate,
    "total_days": totalDays,
    "total_shift": totalShift,
    "remarks": remarks,
    "leave_status_type": leaveStatusType,
    "leave_status": leaveStatus,
    "person_remark": personRemark,
    "leave_data_list": leaveDataList == null ? [] : List<dynamic>.from(leaveDataList!.map((x) => x.toJson())),
  };
}

class LeaveDataList {
  String? id;
  String? tblAppointmentId;
  String? empId;
  String? shiftId;
  String? shiftName;
  DateTime? leaveDate;

  LeaveDataList({
    this.id,
    this.tblAppointmentId,
    this.empId,
    this.shiftId,
    this.shiftName,
    this.leaveDate,
  });

  factory LeaveDataList.fromJson(Map<String, dynamic> json) => LeaveDataList(
    id: json["id"],
    tblAppointmentId: json["tbl_appointment_id"],
    empId: json["emp_id"],
    shiftId: json["shift_id"],
    shiftName: json["shift_name"],
    leaveDate: json["leave_date"] == null ? null : DateTime.parse(json["leave_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tbl_appointment_id": tblAppointmentId,
    "emp_id": empId,
    "shift_id": shiftId,
    "shift_name": shiftName,
    "leave_date": "${leaveDate!.year.toString().padLeft(4, '0')}-${leaveDate!.month.toString().padLeft(2, '0')}-${leaveDate!.day.toString().padLeft(2, '0')}",
  };
}
