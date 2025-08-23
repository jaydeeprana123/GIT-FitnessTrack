// To parse this JSON data, do
//
//     final addLeaveRequestModel = addLeaveRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:fitness_track/Screens/LeaveManagement/model/leave_shift_list_model.dart';
import 'package:flutter/cupertino.dart';

import '../../DayInDayOut/model/shif_list_model.dart';

AddLeaveRequestModel addLeaveRequestModelFromJson(String str) => AddLeaveRequestModel.fromJson(json.decode(str));

String addLeaveRequestModelToJson(AddLeaveRequestModel data) => json.encode(data.toJson());

class AddLeaveRequestModel {
  String? id;
  String? empId;
  String? branchId;
  String? leaveCategoryId;
  String? totalDays;
  String? totalShift;
  String? remarks;
  List<LeaveRequestData>? dataLeave;

  AddLeaveRequestModel({
    this.id,
    this.empId,
    this.branchId,
    this.leaveCategoryId,
    this.totalDays,
    this.totalShift,
    this.remarks,
    this.dataLeave,
  });

  factory AddLeaveRequestModel.fromJson(Map<String, dynamic> json) => AddLeaveRequestModel(
    id: json["id"],
    empId: json["emp_id"],
    branchId: json["branch_id"],
    leaveCategoryId: json["leave_category_id"],
    totalDays: json["total_days"],
    totalShift: json["total_shift"],
    remarks: json["remarks"],
    dataLeave: json["data_leave"] == null ? [] : List<LeaveRequestData>.from(json["data_leave"]!.map((x) => LeaveRequestData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "emp_id": empId,
    "branch_id": branchId,
    "leave_category_id": leaveCategoryId,
    "total_days": totalDays,
    "total_shift": totalShift,
    "remarks": remarks,
    "data_leave": dataLeave == null ? [] : List<dynamic>.from(dataLeave!.map((x) => x.toJson())),
  };
}

class LeaveRequestData {
  String? id;
  String? leaveDate;
  String? shiftId;
  String? shiftName;
  String? branchId;
  TextEditingController? leaveDateEditingController;
  List<LeaveShiftData>? shiftDataList;

  LeaveRequestData({
    this.id,
    this.leaveDate,
    this.shiftId,
    this.shiftName,
    this.branchId,
    this.shiftDataList,
    this.leaveDateEditingController
  });

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) => LeaveRequestData(
    id: json["id"],
    leaveDate: json["leave_date"],
    shiftId: json["shift_id"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "leave_date": leaveDate,
    "shift_id": shiftId,
  };
}
