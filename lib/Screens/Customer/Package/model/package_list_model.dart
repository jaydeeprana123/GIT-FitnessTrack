// To parse this JSON data, do
//
//     final packageListModel = packageListModelFromJson(jsonString);

import 'dart:convert';

PackageListModel packageListModelFromJson(String str) => PackageListModel.fromJson(json.decode(str));

String packageListModelToJson(PackageListModel data) => json.encode(data.toJson());

class PackageListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<PackageData>? data;

  PackageListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory PackageListModel.fromJson(Map<String, dynamic> json) => PackageListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<PackageData>.from(json["data"]!.map((x) => PackageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PackageData {
  String? id;
  String? packageName;
  String? packageCategoryId;
  String? packageCategoryName;
  String? duration;
  String? amount;
  String? packageDescription;
  String? remarks;
  String? status;
  String? deleteStatus;

  PackageData({
    this.id,
    this.packageName,
    this.packageCategoryId,
    this.packageCategoryName,
    this.duration,
    this.amount,
    this.packageDescription,
    this.remarks,
    this.status,
    this.deleteStatus,
  });

  factory PackageData.fromJson(Map<String, dynamic> json) => PackageData(
    id: json["id"],
    packageName: json["package_name"],
    packageCategoryId: json["package_category_id"],
    packageCategoryName: json["package_category_name"],
    duration: json["duration"],
    amount: json["amount"],
    packageDescription: json["package_description"],
    remarks: json["remarks"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_name": packageName,
    "package_category_id": packageCategoryId,
    "package_category_name": packageCategoryName,
    "duration": duration,
    "amount": amount,
    "package_description": packageDescription,
    "remarks": remarks,
    "status": status,
    "delete_status": deleteStatus,
  };
}

