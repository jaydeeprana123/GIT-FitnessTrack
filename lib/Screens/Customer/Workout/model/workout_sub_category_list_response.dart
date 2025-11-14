// To parse this JSON data, do
//
//     final workoutSubCategoryResponse = workoutSubCategoryResponseFromJson(jsonString);

import 'dart:convert';

WorkoutSubCategoryResponse workoutSubCategoryResponseFromJson(String str) =>
    WorkoutSubCategoryResponse.fromJson(json.decode(str));

String workoutSubCategoryResponseToJson(WorkoutSubCategoryResponse data) =>
    json.encode(data.toJson());

class WorkoutSubCategoryResponse {
  bool? status;
  String? message;
  String? accessToken;
  List<WorkoutSubCategoryData>? data;

  WorkoutSubCategoryResponse({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory WorkoutSubCategoryResponse.fromJson(Map<String, dynamic> json) =>
      WorkoutSubCategoryResponse(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"],
        data: json["data"] == null
            ? []
            : List<WorkoutSubCategoryData>.from(
                json["data"]!.map((x) => WorkoutSubCategoryData.fromJson(x))),
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

class WorkoutSubCategoryData {
  String? id;
  String? name;

  WorkoutSubCategoryData({
    this.id,
    this.name,
  });

  factory WorkoutSubCategoryData.fromJson(Map<String, dynamic> json) =>
      WorkoutSubCategoryData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
