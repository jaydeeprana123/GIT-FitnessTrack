// To parse this JSON data, do
//
//     final stateListModel = stateListModelFromJson(jsonString);

import 'dart:convert';

StateListModel stateListModelFromJson(String str) => StateListModel.fromJson(json.decode(str));

String stateListModelToJson(StateListModel data) => json.encode(data.toJson());

class StateListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<StateData>? data;

  StateListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory StateListModel.fromJson(Map<String, dynamic> json) => StateListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<StateData>.from(json["data"]!.map((x) => StateData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StateData {
  String? id;
  String? name;

  StateData({
    this.id,
    this.name,
  });

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
