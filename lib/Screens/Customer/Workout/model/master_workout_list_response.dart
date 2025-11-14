// To parse this JSON data, do
//
//     final masterWorkoutListResponse = masterWorkoutListResponseFromJson(jsonString);

import 'dart:convert';

MasterWorkoutListResponse masterWorkoutListResponseFromJson(String str) =>
    MasterWorkoutListResponse.fromJson(json.decode(str));

String masterWorkoutListResponseToJson(MasterWorkoutListResponse data) =>
    json.encode(data.toJson());

class MasterWorkoutListResponse {
  bool? status;
  String? message;
  String? accessToken;
  List<MasterWorkoutData>? data;

  MasterWorkoutListResponse({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory MasterWorkoutListResponse.fromJson(Map<String, dynamic> json) =>
      MasterWorkoutListResponse(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"],
        data: json["data"] == null
            ? []
            : List<MasterWorkoutData>.from(
                json["data"]!.map((x) => MasterWorkoutData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "access_token": accessToken,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MasterWorkoutData {
  String? id;
  String? name;

  MasterWorkoutData({
    this.id,
    this.name,
  });

  factory MasterWorkoutData.fromJson(Map<String, dynamic> json) =>
      MasterWorkoutData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
