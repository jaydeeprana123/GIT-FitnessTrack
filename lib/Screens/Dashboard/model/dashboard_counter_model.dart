// To parse this JSON data, do
//
//     final dashboardCounterModel = dashboardCounterModelFromJson(jsonString);

import 'dart:convert';

DashboardCounterModel dashboardCounterModelFromJson(String str) => DashboardCounterModel.fromJson(json.decode(str));

String dashboardCounterModelToJson(DashboardCounterModel data) => json.encode(data.toJson());

class DashboardCounterModel {
  bool? status;
  String? message;
  List<DashboardData>? data;

  DashboardCounterModel({
    this.status,
    this.message,
    this.data,
  });

  factory DashboardCounterModel.fromJson(Map<String, dynamic> json) => DashboardCounterModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DashboardData>.from(json["data"]!.map((x) => DashboardData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DashboardData {
  String? holidays;
  String? lateMark;
  String? overTime;
  String? absent;
  dynamic branchLatData;
  dynamic branchLongData;

  DashboardData({
    this.holidays,
    this.lateMark,
    this.overTime,
    this.absent,
    this.branchLatData,
    this.branchLongData,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    holidays: json["holidays"],
    lateMark: json["late_mark"],
    overTime: json["over_time"],
    absent: json["absent"],
    branchLatData: json["branch_lat_data"],
    branchLongData: json["branch_long_data"],
  );

  Map<String, dynamic> toJson() => {
    "holidays": holidays,
    "late_mark": lateMark,
    "over_time": overTime,
    "absent": absent,
    "branch_lat_data": branchLatData,
    "branch_long_data": branchLongData,
  };
}
