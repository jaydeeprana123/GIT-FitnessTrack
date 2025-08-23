// To parse this JSON data, do
//
//     final employeeAttendanceListModel = employeeAttendanceListModelFromJson(jsonString);

import 'dart:convert';

EmployeeAttendanceListModel employeeAttendanceListModelFromJson(String str) => EmployeeAttendanceListModel.fromJson(json.decode(str));

String employeeAttendanceListModelToJson(EmployeeAttendanceListModel data) => json.encode(data.toJson());

class EmployeeAttendanceListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<EmployeeAttendanceData>? data;

  EmployeeAttendanceListModel({
     this.status,
     this.message,
     this.accessToken,
     this.data,
  });

  factory EmployeeAttendanceListModel.fromJson(Map<String, dynamic> json) => EmployeeAttendanceListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: List<EmployeeAttendanceData>.from(json["data"].map((x) => EmployeeAttendanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data != null?List<dynamic>.from(data!.map((x) => x.toJson())):null,
  };
}

class EmployeeAttendanceData {
  String id;
  String empId;
  String empName;
  String shiftId;
  String shiftName;
  String branchId;
  String branchName;
  String attendanceDate;
  String attendanceTime;
  String day;
  String attendanceType;
  String attendanceTypeName;
  String photo;
  String lateTime;
  String overTime;

  EmployeeAttendanceData({
    required this.id,
    required this.empId,
    required this.empName,
    required this.shiftId,
    required this.shiftName,
    required this.branchId,
    required this.branchName,
    required this.attendanceDate,
    required this.attendanceTime,
    required this.day,
    required this.attendanceType,
    required this.attendanceTypeName,
    required this.photo,
    required this.lateTime,
    required this.overTime,
  });

  factory EmployeeAttendanceData.fromJson(Map<String, dynamic> json) => EmployeeAttendanceData(
    id: json["id"],
    empId: json["emp_id"],
    empName: json["emp_name"],
    shiftId: json["shift_id"],
    shiftName: json["shift_name"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    attendanceDate: json["attendance_date"],
    attendanceTime: json["attendance_time"],
    day: json["day"],
    attendanceType: json["attendance_type"],
    attendanceTypeName: json["attendance_type_name"],
    photo: json["photo"],
    lateTime: json["late_time"],
    overTime: json["over_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "emp_name": empName,
    "shift_id": shiftId,
    "shift_name": shiftName,
    "branch_id": branchId,
    "branch_name": branchName,
    "attendance_date": attendanceDate,
    "attendance_time": attendanceTime,
    "day": day,
    "attendance_type": attendanceType,
    "attendance_type_name": attendanceTypeName,
    "photo": photo,
    "late_time": lateTime,
    "over_time": overTime,
  };
}
