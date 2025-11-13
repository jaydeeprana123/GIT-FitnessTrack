// To parse this JSON data, do
//
//     final warmupListResponse = warmupListResponseFromJson(jsonString);

import 'dart:convert';

WarmupListResponse warmupListResponseFromJson(String str) =>
    WarmupListResponse.fromJson(json.decode(str));

String warmupListResponseToJson(WarmupListResponse data) =>
    json.encode(data.toJson());

class WarmupListResponse {
  bool? status;
  String? message;
  String? accessToken;
  List<WarmupData>? data;

  WarmupListResponse({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory WarmupListResponse.fromJson(Map<String, dynamic> json) =>
      WarmupListResponse(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"],
        data: json["data"] == null
            ? []
            : List<WarmupData>.from(
                json["data"]!.map((x) => WarmupData.fromJson(x))),
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

class WarmupData {
  String? id;
  String? workoutId;
  String? clientId;
  String? workoutName;
  String? sets;
  String? repeatNo;
  String? repeatTime;
  String? status;
  String? statusType;
  String? deleteStatus;

  WarmupData({
    this.id,
    this.workoutId,
    this.clientId,
    this.workoutName,
    this.sets,
    this.repeatNo,
    this.repeatTime,
    this.status,
    this.statusType,
    this.deleteStatus,
  });

  factory WarmupData.fromJson(Map<String, dynamic> json) => WarmupData(
        id: json["id"],
        workoutId: json["workout_id"],
        clientId: json["client_id"],
        workoutName: json["workout_name"],
        sets: json["sets"],
        repeatNo: json["repeat_no"],
        repeatTime: json["repeat_time"],
        status: json["status"],
        statusType: json["status_type"],
        deleteStatus: json["delete_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workout_id": workoutId,
        "client_id": clientId,
        "workout_name": workoutName,
        "sets": sets,
        "repeat_no": repeatNo,
        "repeat_time": repeatTime,
        "status": status,
        "status_type": statusType,
        "delete_status": deleteStatus,
      };
}
