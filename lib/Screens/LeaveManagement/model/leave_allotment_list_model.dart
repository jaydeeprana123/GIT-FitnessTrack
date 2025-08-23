// To parse this JSON data, do
//
//     final leaveAllotementListModel = leaveAllotementListModelFromJson(jsonString);

import 'dart:convert';

LeaveAllotmentListModel leaveAllotmentListModelFromJson(String str) => LeaveAllotmentListModel.fromJson(json.decode(str));

String leaveAllotmentListModelToJson(LeaveAllotmentListModel data) => json.encode(data.toJson());

class LeaveAllotmentListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<LeaveAllotmentData>? data;

  LeaveAllotmentListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory LeaveAllotmentListModel.fromJson(Map<String, dynamic> json) => LeaveAllotmentListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<LeaveAllotmentData>.from(json["data"]!.map((x) => LeaveAllotmentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LeaveAllotmentData {
  String? id;
  String? empId;
  String? leaveCategoryId;
  String? leaveCategoryName;
  String? totalLeave;
  String? leavePendingStatus;
  String? leavePending;
  DateTime? startDate;
  DateTime? endDate;
  String? remarks;

  LeaveAllotmentData({
    this.id,
    this.empId,
    this.leaveCategoryId,
    this.leaveCategoryName,
    this.totalLeave,
    this.leavePendingStatus,
    this.leavePending,
    this.startDate,
    this.endDate,
    this.remarks,
  });

  factory LeaveAllotmentData.fromJson(Map<String, dynamic> json) => LeaveAllotmentData(
    id: json["id"],
    empId: json["emp_id"],
    leaveCategoryId: json["leave_category_id"],
    leaveCategoryName: json["leave_category_name"],
    totalLeave: json["total_leave"],
    leavePendingStatus: json["leave_pending_status"],
    leavePending: json["leave_pending"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "leave_category_id": leaveCategoryId,
    "leave_category_name": leaveCategoryName,
    "total_leave": totalLeave,
    "leave_pending_status": leavePendingStatus,
    "leave_pending": leavePending,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "remarks": remarks,
  };
}
