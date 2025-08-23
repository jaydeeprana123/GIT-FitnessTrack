// To parse this JSON data, do
//
//     final salaryListModel = salaryListModelFromJson(jsonString);

import 'dart:convert';

SalaryListModel salaryListModelFromJson(String str) => SalaryListModel.fromJson(json.decode(str));

String salaryListModelToJson(SalaryListModel data) => json.encode(data.toJson());

class SalaryListModel {
  bool? status;
  String? message;
  List<SalaryData>? data;

  SalaryListModel({
    this.status,
    this.message,
    this.data,
  });

  factory SalaryListModel.fromJson(Map<String, dynamic> json) => SalaryListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SalaryData>.from(json["data"]!.map((x) => SalaryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SalaryData {
  String? id;
  String? empId;
  DateTime? startDate;
  DateTime? endDate;
  String? basicSalary;
  String? sundayAmt;
  String? totalSundays;
  String? petrol;
  String? overTimeAmt;
  String? totalOverTime;
  String? mgrMonthInc;
  String? penaltyAmt;
  String? totalPenalty;
  String? incomeInc;
  String? absentAmt;
  String? totalAbsent;
  String? lateMinAmt;
  String? totalLateMin;
  String? ppf;
  String? pTax;
  String? grossTotal;
  String? incGiven;
  String? advance;
  String? netTotal;
  String? targetComplete;

  SalaryData({
    this.id,
    this.empId,
    this.startDate,
    this.endDate,
    this.basicSalary,
    this.sundayAmt,
    this.totalSundays,
    this.petrol,
    this.overTimeAmt,
    this.totalOverTime,
    this.mgrMonthInc,
    this.penaltyAmt,
    this.totalPenalty,
    this.incomeInc,
    this.absentAmt,
    this.totalAbsent,
    this.lateMinAmt,
    this.totalLateMin,
    this.ppf,
    this.pTax,
    this.grossTotal,
    this.incGiven,
    this.advance,
    this.netTotal,
    this.targetComplete,
  });

  factory SalaryData.fromJson(Map<String, dynamic> json) => SalaryData(
    id: json["id"],
    empId: json["emp_id"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    basicSalary: json["basic_salary"],
    sundayAmt: json["sunday_amt"],
    totalSundays: json["total_sundays"],
    petrol: json["petrol"],
    overTimeAmt: json["over_time_amt"],
    totalOverTime: json["total_over_time"],
    mgrMonthInc: json["mgr_month_inc"],
    penaltyAmt: json["penalty_amt"],
    totalPenalty: json["total_penalty"],
    incomeInc: json["income_inc"],
    absentAmt: json["absent_amt"],
    totalAbsent: json["total_absent"],
    lateMinAmt: json["late_min_amt"],
    totalLateMin: json["total_late_min"],
    ppf: json["ppf"],
    pTax: json["p_tax"],
    grossTotal: json["gross_total"],
    incGiven: json["inc_given"],
    advance: json["advance"],
    netTotal: json["net_total"],
    targetComplete: json["target_complete"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "basic_salary": basicSalary,
    "sunday_amt": sundayAmt,
    "total_sundays": totalSundays,
    "petrol": petrol,
    "over_time_amt": overTimeAmt,
    "total_over_time": totalOverTime,
    "mgr_month_inc": mgrMonthInc,
    "penalty_amt": penaltyAmt,
    "total_penalty": totalPenalty,
    "income_inc": incomeInc,
    "absent_amt": absentAmt,
    "total_absent": totalAbsent,
    "late_min_amt": lateMinAmt,
    "total_late_min": totalLateMin,
    "ppf": ppf,
    "p_tax": pTax,
    "gross_total": grossTotal,
    "inc_given": incGiven,
    "advance": advance,
    "net_total": netTotal,
    "target_complete": targetComplete,
  };
}
