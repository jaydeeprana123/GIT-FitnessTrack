// To parse this JSON data, do
//
//     final workoutTrainingListResponse = workoutTrainingListResponseFromJson(jsonString);

import 'dart:convert';

WorkoutTrainingListResponse workoutTrainingListResponseFromJson(String str) =>
    WorkoutTrainingListResponse.fromJson(json.decode(str));

String workoutTrainingListResponseToJson(WorkoutTrainingListResponse data) =>
    json.encode(data.toJson());

class WorkoutTrainingListResponse {
  bool? status;
  String? message;
  String? accessToken;
  List<WorkoutTrainingData>? data;

  WorkoutTrainingListResponse({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory WorkoutTrainingListResponse.fromJson(Map<String, dynamic> json) =>
      WorkoutTrainingListResponse(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"],
        data: json["data"] == null
            ? []
            : List<WorkoutTrainingData>.from(
                json["data"]!.map((x) => WorkoutTrainingData.fromJson(x))),
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

class WorkoutTrainingData {
  String? workoutTrainingId;
  String? workoutId;
  String? clientId;
  String? day;
  String? status;
  String? statusType;
  String? deleteStatus;
  List<WorkoutList>? workoutList;

  WorkoutTrainingData({
    this.workoutTrainingId,
    this.workoutId,
    this.clientId,
    this.day,
    this.status,
    this.statusType,
    this.deleteStatus,
    this.workoutList,
  });

  factory WorkoutTrainingData.fromJson(Map<String, dynamic> json) =>
      WorkoutTrainingData(
        workoutTrainingId: json["workout_training_id"],
        workoutId: json["workout_id"],
        clientId: json["client_id"],
        day: json["day"],
        status: json["status"],
        statusType: json["status_type"],
        deleteStatus: json["delete_status"],
        workoutList: json["workout_list"] == null
            ? []
            : List<WorkoutList>.from(
                json["workout_list"]!.map((x) => WorkoutList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "workout_training_id": workoutTrainingId,
        "workout_id": workoutId,
        "client_id": clientId,
        "day": day,
        "status": status,
        "status_type": statusType,
        "delete_status": deleteStatus,
        "workout_list": workoutList == null
            ? []
            : List<dynamic>.from(workoutList!.map((x) => x.toJson())),
      };
}

class WorkoutList {
  String? workoutTrainingId;
  String? workoutTrainingCategoryId;
  String? masterWorkoutId;
  String? masterWorkoutName;
  String? status;
  String? statusType;
  String? deleteStatus;
  List<WorkoutDetailList>? workoutDetailList;

  WorkoutList({
    this.workoutTrainingId,
    this.workoutTrainingCategoryId,
    this.masterWorkoutId,
    this.masterWorkoutName,
    this.status,
    this.statusType,
    this.deleteStatus,
    this.workoutDetailList,
  });

  factory WorkoutList.fromJson(Map<String, dynamic> json) => WorkoutList(
        workoutTrainingId: json["workout_training_id"],
        workoutTrainingCategoryId: json["workout_training_category_id"],
        masterWorkoutId: json["master_workout_id"],
        masterWorkoutName: json["master_workout_name"],
        status: json["status"],
        statusType: json["status_type"],
        deleteStatus: json["delete_status"],
        workoutDetailList: json["workout_detail_list"] == null
            ? []
            : List<WorkoutDetailList>.from(json["workout_detail_list"]!
                .map((x) => WorkoutDetailList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "workout_training_id": workoutTrainingId,
        "workout_training_category_id": workoutTrainingCategoryId,
        "master_workout_id": masterWorkoutId,
        "master_workout_name": masterWorkoutName,
        "status": status,
        "status_type": statusType,
        "delete_status": deleteStatus,
        "workout_detail_list": workoutDetailList == null
            ? []
            : List<dynamic>.from(workoutDetailList!.map((x) => x.toJson())),
      };
}

class WorkoutDetailList {
  String? workoutTrainingSubCategoryId;
  String? workoutTrainingId;
  String? workoutTrainingCategoryId;
  String? workoutDetailId;
  String? workoutDetailName;
  String? sets;
  String? repeatNo;
  String? repeatTime;
  String? remarks;
  String? status;
  String? statusType;
  String? deleteStatus;

  WorkoutDetailList({
    this.workoutTrainingSubCategoryId,
    this.workoutTrainingId,
    this.workoutTrainingCategoryId,
    this.workoutDetailId,
    this.workoutDetailName,
    this.sets,
    this.repeatNo,
    this.repeatTime,
    this.remarks,
    this.status,
    this.statusType,
    this.deleteStatus,
  });

  factory WorkoutDetailList.fromJson(Map<String, dynamic> json) =>
      WorkoutDetailList(
        workoutTrainingSubCategoryId: json["workout_training_sub_category_id"],
        workoutTrainingId: json["workout_training_id"],
        workoutTrainingCategoryId: json["workout_training_category_id"],
        workoutDetailId: json["workout_detail_id"],
        workoutDetailName: json["workout_detail_name"],
        sets: json["sets"],
        repeatNo: json["repeat_no"],
        repeatTime: json["repeat_time"],
        remarks: json["remarks"],
        status: json["status"],
        statusType: json["status_type"],
        deleteStatus: json["delete_status"],
      );

  Map<String, dynamic> toJson() => {
        "workout_training_sub_category_id": workoutTrainingSubCategoryId,
        "workout_training_id": workoutTrainingId,
        "workout_training_category_id": workoutTrainingCategoryId,
        "workout_detail_id": workoutDetailId,
        "workout_detail_name": workoutDetailName,
        "sets": sets,
        "repeat_no": repeatNo,
        "repeat_time": repeatTime,
        "remarks": remarks,
        "status": status,
        "status_type": statusType,
        "delete_status": deleteStatus,
      };
}
