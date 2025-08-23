// To parse this JSON data, do
//
//     final leaveCategoryListModel = leaveCategoryListModelFromJson(jsonString);

import 'dart:convert';

LeaveCategoryListModel leaveCategoryListModelFromJson(String str) => LeaveCategoryListModel.fromJson(json.decode(str));

String leaveCategoryListModelToJson(LeaveCategoryListModel data) => json.encode(data.toJson());

class LeaveCategoryListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<LeaveCategoryData>? data;

  LeaveCategoryListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory LeaveCategoryListModel.fromJson(Map<String, dynamic> json) => LeaveCategoryListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<LeaveCategoryData>.from(json["data"]!.map((x) => LeaveCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LeaveCategoryData {
  String? id;
  String? name;

  LeaveCategoryData({
    this.id,
    this.name,
  });

  factory LeaveCategoryData.fromJson(Map<String, dynamic> json) => LeaveCategoryData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
