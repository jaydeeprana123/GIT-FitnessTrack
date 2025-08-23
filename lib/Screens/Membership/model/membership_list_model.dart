// To parse this JSON data, do
//
//     final membershipListModel = membershipListModelFromJson(jsonString);

import 'dart:convert';

MembershipListModel membershipListModelFromJson(String str) => MembershipListModel.fromJson(json.decode(str));

String membershipListModelToJson(MembershipListModel data) => json.encode(data.toJson());

class MembershipListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<MembershipData>? data;

  MembershipListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory MembershipListModel.fromJson(Map<String, dynamic> json) => MembershipListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<MembershipData>.from(json["data"]!.map((x) => MembershipData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MembershipData {
  String? id;
  String? customerId;
  String? packageType;
  String? admissionUniqueCode;
  String? month;
  dynamic day;
  String? startingDate;
  String? endingDate;
  String? approvalStatusType;
  String? approvalStatus;
  String? status;
  String? deleteStatus;

  MembershipData({
    this.id,
    this.customerId,
    this.packageType,
    this.admissionUniqueCode,
    this.month,
    this.day,
    this.startingDate,
    this.endingDate,
    this.approvalStatusType,
    this.approvalStatus,
    this.status,
    this.deleteStatus,
  });

  factory MembershipData.fromJson(Map<String, dynamic> json) => MembershipData(
    id: json["id"],
    customerId: json["customer_id"],
    packageType: json["package_type"],
    admissionUniqueCode: json["admission_unique_code"],
    month: json["month"],
    day: json["day"],
    startingDate: json["starting_date"],
    endingDate: json["ending_date"],
    approvalStatusType: json["approval_status_type"],
    approvalStatus: json["approval_status"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "package_type": packageType,
    "admission_unique_code": admissionUniqueCode,
    "month": month,
    "day": day,
    "starting_date": startingDate,
    "ending_date": endingDate,
    "approval_status_type": approvalStatusType,
    "approval_status": approvalStatus,
    "status": status,
    "delete_status": deleteStatus,
  };
}
