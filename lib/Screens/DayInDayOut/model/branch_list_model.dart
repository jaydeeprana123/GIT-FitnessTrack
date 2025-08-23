// To parse this JSON data, do
//
//     final branchListModel = branchListModelFromJson(jsonString);

import 'dart:convert';

BranchListModel branchListModelFromJson(String str) => BranchListModel.fromJson(json.decode(str));

String branchListModelToJson(BranchListModel data) => json.encode(data.toJson());

class BranchListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<BranchData>? data;

  BranchListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory BranchListModel.fromJson(Map<String, dynamic> json) => BranchListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<BranchData>.from(json["data"]!.map((x) => BranchData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BranchData {
  String? id;
  String? code;
  String? name;
  String? address;
  String? lat;
  String? long;

  BranchData({
    this.id,
    this.code,
    this.name,
    this.address,
    this.lat,
    this.long,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "address": address,
    "lat": lat,
    "long": long,
  };
}
