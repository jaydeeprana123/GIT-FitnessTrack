// To parse this JSON data, do
//
//     final measurementListModel = measurementListModelFromJson(jsonString);

import 'dart:convert';

MeasurementListModel measurementListModelFromJson(String str) => MeasurementListModel.fromJson(json.decode(str));

String measurementListModelToJson(MeasurementListModel data) => json.encode(data.toJson());

class MeasurementListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<MeasurementData>? data;

  MeasurementListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory MeasurementListModel.fromJson(Map<String, dynamic> json) => MeasurementListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<MeasurementData>.from(json["data"]!.map((x) => MeasurementData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MeasurementData {
  String? measurementId;
  String? code;
  String? code1;
  String? clientId;
  String? clientName;
  dynamic trainerId;
  dynamic trainerName;
  String? frontView;
  String? backView;
  String? leftView;
  String? rightView;
  DateTime? date;
  String? weight;
  String? height;
  String? neck;
  String? shoulder;
  String? normalChest;
  String? expandedChest;
  String? upperArm;
  String? foreArm;
  String? upperAbdomen;
  String? waist;
  String? lowerAbdomen;
  String? hips;
  String? thigh;
  String? calf;
  String? whr;
  String? bmi;
  String? sign;
  String? bicep;
  String? tricep;
  String? subscapula;
  String? suprailliac;
  String? total;
  String? percentage;
  String? healthRisk;
  String? low;
  String? medium;
  String? high;
  String? underweight;
  String? normal;
  String? overweight;
  String? obeseGrade1;
  String? obeseGrade2;
  String? obeseGrade3;
  String? bmr;
  String? status;
  String? deleteStatus;

  MeasurementData({
    this.measurementId,
    this.code,
    this.code1,
    this.clientId,
    this.clientName,
    this.trainerId,
    this.trainerName,
    this.frontView,
    this.backView,
    this.leftView,
    this.rightView,
    this.date,
    this.weight,
    this.height,
    this.neck,
    this.shoulder,
    this.normalChest,
    this.expandedChest,
    this.upperArm,
    this.foreArm,
    this.upperAbdomen,
    this.waist,
    this.lowerAbdomen,
    this.hips,
    this.thigh,
    this.calf,
    this.whr,
    this.bmi,
    this.sign,
    this.bicep,
    this.tricep,
    this.subscapula,
    this.suprailliac,
    this.total,
    this.percentage,
    this.healthRisk,
    this.low,
    this.medium,
    this.high,
    this.underweight,
    this.normal,
    this.overweight,
    this.obeseGrade1,
    this.obeseGrade2,
    this.obeseGrade3,
    this.bmr,
    this.status,
    this.deleteStatus,
  });

  factory MeasurementData.fromJson(Map<String, dynamic> json) => MeasurementData(
    measurementId: json["measurement_id"],
    code: json["code"],
    code1: json["code1"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    trainerId: json["trainer_id"],
    trainerName:json["trainer_name"],
    frontView: json["front_view"],
    backView: json["back_view"],
    leftView: json["left_view"],
    rightView: json["right_view"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    weight: json["weight"],
    height: json["height"],
    neck: json["neck"],
    shoulder: json["shoulder"],
    normalChest: json["normal_chest"],
    expandedChest: json["expanded_chest"],
    upperArm: json["upper_arm"],
    foreArm: json["fore_arm"],
    upperAbdomen: json["upper_abdomen"],
    waist: json["waist"],
    lowerAbdomen: json["lower_abdomen"],
    hips: json["hips"],
    thigh: json["thigh"],
    calf: json["calf"],
    whr: json["whr"],
    bmi: json["bmi"],
    sign: json["sign"],
    bicep: json["bicep"],
    tricep: json["tricep"],
    subscapula: json["subscapula"],
    suprailliac: json["suprailliac"],
    total: json["total"],
    percentage: json["percentage"],
    healthRisk: json["health_risk"],
    low: json["low"],
    medium: json["medium"],
    high: json["high"],
    underweight: json["underweight"],
    normal: json["normal"],
    overweight: json["overweight"],
    obeseGrade1: json["obese_grade_1"],
    obeseGrade2: json["obese_grade_2"],
    obeseGrade3: json["obese_grade_3"],
    bmr: json["bmr"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "measurement_id": measurementId,
    "code": code,
    "code1": code1,
    "client_id": clientId,
    "client_name": clientName,
    "trainer_id": trainerId,
    "trainer_name":trainerName,
    "front_view": frontView,
    "back_view": backView,
    "left_view": leftView,
    "right_view": rightView,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "weight": weight,
    "height": height,
    "neck": neck,
    "shoulder": shoulder,
    "normal_chest": normalChest,
    "expanded_chest": expandedChest,
    "upper_arm": upperArm,
    "fore_arm": foreArm,
    "upper_abdomen": upperAbdomen,
    "waist": waist,
    "lower_abdomen": lowerAbdomen,
    "hips": hips,
    "thigh": thigh,
    "calf": calf,
    "whr": whr,
    "bmi": bmi,
    "sign": sign,
    "bicep": bicep,
    "tricep": tricep,
    "subscapula": subscapula,
    "suprailliac": suprailliac,
    "total": total,
    "percentage": percentage,
    "health_risk": healthRisk,
    "low": low,
    "medium": medium,
    "high": high,
    "underweight": underweight,
    "normal": normal,
    "overweight": overweight,
    "obese_grade_1": obeseGrade1,
    "obese_grade_2": obeseGrade2,
    "obese_grade_3": obeseGrade3,
    "bmr": bmr,
    "status": status,
    "delete_status": deleteStatus,
  };
}



