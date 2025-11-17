// To parse this JSON data, do
//
//     final workoutTrainingAddEditRequest = workoutTrainingAddEditRequestFromJson(jsonString);

import 'dart:convert';

WorkoutTrainingAddEditRequest workoutTrainingAddEditRequestFromJson(
        String str) =>
    WorkoutTrainingAddEditRequest.fromJson(json.decode(str));

String workoutTrainingAddEditRequestToJson(
        WorkoutTrainingAddEditRequest data) =>
    json.encode(data.toJson());

class WorkoutTrainingAddEditRequest {
  String? id;
  String? clientId;
  String? currentLoginId;
  String? workoutId;
  int? days;
  String? status;
  List<Workout>? workout;
  List<RemovedWorkoutTrainingCategory>? removedWorkoutTrainingCategory;
  List<RemovedWorkoutTrainingSubCategory>? removedWorkoutTrainingSubCategory;

  WorkoutTrainingAddEditRequest({
    this.id,
    this.clientId,
    this.currentLoginId,
    this.workoutId,
    this.days,
    this.status,
    this.workout,
    this.removedWorkoutTrainingCategory,
    this.removedWorkoutTrainingSubCategory,
  });

  factory WorkoutTrainingAddEditRequest.fromJson(Map<String, dynamic> json) =>
      WorkoutTrainingAddEditRequest(
        id: json["id"],
        clientId: json["client_id"],
        currentLoginId: json["current_login_id"],
        workoutId: json["workout_id"],
        days: json["days"],
        status: json["status"],
        workout: json["workout"] == null
            ? []
            : List<Workout>.from(
                json["workout"]!.map((x) => Workout.fromJson(x))),
        removedWorkoutTrainingCategory:
            json["removed_workout_training_category"] == null
                ? []
                : List<RemovedWorkoutTrainingCategory>.from(
                    json["removed_workout_training_category"]!.map(
                        (x) => RemovedWorkoutTrainingCategory.fromJson(x))),
        removedWorkoutTrainingSubCategory:
            json["removed_workout_training_sub_category"] == null
                ? []
                : List<RemovedWorkoutTrainingSubCategory>.from(
                    json["removed_workout_training_sub_category"]!.map(
                        (x) => RemovedWorkoutTrainingSubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "current_login_id": currentLoginId,
        "workout_id": workoutId,
        "days": days,
        "status": status,
        "workout": workout == null
            ? []
            : List<dynamic>.from(workout!.map((x) => x.toJson())),
        "removed_workout_training_category":
            removedWorkoutTrainingCategory == null
                ? []
                : List<dynamic>.from(
                    removedWorkoutTrainingCategory!.map((x) => x.toJson())),
        "removed_workout_training_sub_category":
            removedWorkoutTrainingSubCategory == null
                ? []
                : List<dynamic>.from(
                    removedWorkoutTrainingSubCategory!.map((x) => x.toJson())),
      };
}

class RemovedWorkoutTrainingCategory {
  String? removedWorkoutTrainingCategoryId;

  RemovedWorkoutTrainingCategory({
    this.removedWorkoutTrainingCategoryId,
  });

  factory RemovedWorkoutTrainingCategory.fromJson(Map<String, dynamic> json) =>
      RemovedWorkoutTrainingCategory(
        removedWorkoutTrainingCategoryId:
            json["removed_workout_training_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "removed_workout_training_category_id":
            removedWorkoutTrainingCategoryId,
      };
}

class RemovedWorkoutTrainingSubCategory {
  String? removedWorkoutTrainingSubCategoryId;

  RemovedWorkoutTrainingSubCategory({
    this.removedWorkoutTrainingSubCategoryId,
  });

  factory RemovedWorkoutTrainingSubCategory.fromJson(
          Map<String, dynamic> json) =>
      RemovedWorkoutTrainingSubCategory(
        removedWorkoutTrainingSubCategoryId:
            json["removed_workout_training_sub_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "removed_workout_training_sub_category_id":
            removedWorkoutTrainingSubCategoryId,
      };
}

class Workout {
  String? workoutTrainingCategoryId;
  String? workoutId;
  List<WorkoutDetail>? workoutDetail;

  Workout({
    this.workoutTrainingCategoryId,
    this.workoutId,
    this.workoutDetail,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        workoutTrainingCategoryId: json["workout_training_category_id"],
        workoutId: json["workout_id"],
        workoutDetail: json["workout_detail"] == null
            ? []
            : List<WorkoutDetail>.from(
                json["workout_detail"]!.map((x) => WorkoutDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "workout_training_category_id": workoutTrainingCategoryId,
        "workout_id": workoutId,
        "workout_detail": workoutDetail == null
            ? []
            : List<dynamic>.from(workoutDetail!.map((x) => x.toJson())),
      };
}

class WorkoutDetail {
  String? workoutTrainingSubCategoryId;
  String? workoutDetailId;
  String? sets;
  String? repeatNo;
  String? repeatTime;
  String? remarks;

  WorkoutDetail({
    this.workoutTrainingSubCategoryId,
    this.workoutDetailId,
    this.sets,
    this.repeatNo,
    this.repeatTime,
    this.remarks,
  });

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) => WorkoutDetail(
        workoutTrainingSubCategoryId: json["workout_training_sub_category_id"],
        workoutDetailId: json["workout_detail_id"],
        sets: json["sets"],
        repeatNo: json["repeat_no"],
        repeatTime: json["repeat_time"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "workout_training_sub_category_id": workoutTrainingSubCategoryId,
        "workout_detail_id": workoutDetailId,
        "sets": sets,
        "repeat_no": repeatNo,
        "repeat_time": repeatTime,
        "remarks": remarks,
      };
}
