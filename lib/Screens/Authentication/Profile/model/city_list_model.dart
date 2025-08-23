// To parse this JSON data, do
//
//     final cityListModel = cityListModelFromJson(jsonString);

import 'dart:convert';

CityListModel cityListModelFromJson(String str) => CityListModel.fromJson(json.decode(str));

String cityListModelToJson(CityListModel data) => json.encode(data.toJson());

class CityListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<CityData>? data;

  CityListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<CityData>.from(json["data"]!.map((x) => CityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CityData {
  String? id;
  String? stateId;
  String? stateName;
  String? cityName;

  CityData({
    this.id,
    this.stateId,
    this.stateName,
    this.cityName,
  });

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
    id: json["id"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state_id": stateId,
    "state_name": stateName,
    "city_name": cityName,
  };
}
