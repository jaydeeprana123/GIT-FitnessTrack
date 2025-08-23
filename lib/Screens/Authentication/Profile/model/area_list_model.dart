// To parse this JSON data, do
//
//     final areaListModel = areaListModelFromJson(jsonString);

import 'dart:convert';

AreaListModel areaListModelFromJson(String str) => AreaListModel.fromJson(json.decode(str));

String areaListModelToJson(AreaListModel data) => json.encode(data.toJson());

class AreaListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<AreaData>? data;

  AreaListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory AreaListModel.fromJson(Map<String, dynamic> json) => AreaListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<AreaData>.from(json["data"]!.map((x) => AreaData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AreaData {
  String? id;
  String? cityId;
  String? cityName;
  String? areaName;

  AreaData({
    this.id,
    this.cityId,
    this.cityName,
    this.areaName,
  });

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
    id: json["id"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    areaName: json["area_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city_id": cityId,
    "city_name": cityName,
    "area_name": areaName,
  };
}
