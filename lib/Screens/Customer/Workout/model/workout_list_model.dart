// To parse this JSON data, do
//
//     final workoutListModel = workoutListModelFromJson(jsonString);

import 'dart:convert';

WorkoutListModel workoutListModelFromJson(String str) => WorkoutListModel.fromJson(json.decode(str));

String workoutListModelToJson(WorkoutListModel data) => json.encode(data.toJson());

class WorkoutListModel {
  bool? status;
  String? message;
  String? accessToken;
  List<WorkoutData>? data;

  WorkoutListModel({
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  factory WorkoutListModel.fromJson(Map<String, dynamic> json) => WorkoutListModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    data: json["data"] == null ? [] : List<WorkoutData>.from(json["data"]!.map((x) => WorkoutData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WorkoutData {
  String? workoutId;
  String? clientId;
  String? measurementId;
  String? code;
  DateTime? workoutDate;
  String? durationInDays;
  DateTime? dueDate;
  String? workoutStatus;
  String? workoutStatusYesNo;
  String? choice;
  String? empWorkoutId;
  String? branchId;
  String? empId;
  String? isEmployee;
  String? status;
  String? deleteStatus;
  List<WarmupList>? warmupList;
  List<WorkoutTrainingList>? workoutTrainingList;

  WorkoutData({
    this.workoutId,
    this.clientId,
    this.measurementId,
    this.code,
    this.workoutDate,
    this.durationInDays,
    this.dueDate,
    this.workoutStatus,
    this.workoutStatusYesNo,
    this.choice,
    this.empWorkoutId,
    this.branchId,
    this.empId,
    this.isEmployee,
    this.status,
    this.deleteStatus,
    this.warmupList,
    this.workoutTrainingList,
  });

  factory WorkoutData.fromJson(Map<String, dynamic> json) => WorkoutData(
    workoutId: json["workout_id"],
    clientId: json["client_id"],
    measurementId: json["measurement_id"],
    code: json["code"],
    workoutDate: json["workout_date"] == null ? null : DateTime.parse(json["workout_date"]),
    durationInDays: json["duration_in_days"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    workoutStatus: json["workout_status"],
    workoutStatusYesNo: json["workout_status_yes_no"],
    choice: json["choice"],
    empWorkoutId: json["emp_workout_id"],
    branchId: json["branch_id"],
    empId: json["emp_id"],
    isEmployee: json["is_employee"],
    status: json["status"],
    deleteStatus: json["delete_status"],
    warmupList: json["warmup_list"] == null ? [] : List<WarmupList>.from(json["warmup_list"]!.map((x) => WarmupList.fromJson(x))),
    workoutTrainingList: json["workout_training_list"] == null ? [] : List<WorkoutTrainingList>.from(json["workout_training_list"]!.map((x) => WorkoutTrainingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "workout_id": workoutId,
    "client_id": clientId,
    "measurement_id": measurementId,
    "code": code,
    "workout_date": "${workoutDate!.year.toString().padLeft(4, '0')}-${workoutDate!.month.toString().padLeft(2, '0')}-${workoutDate!.day.toString().padLeft(2, '0')}",
    "duration_in_days": durationInDays,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "workout_status": workoutStatus,
    "workout_status_yes_no": workoutStatusYesNo,
    "choice": choice,
    "emp_workout_id": empWorkoutId,
    "branch_id": branchId,
    "emp_id": empId,
    "is_employee": isEmployee,
    "status": status,
    "delete_status": deleteStatus,
    "warmup_list": warmupList == null ? [] : List<dynamic>.from(warmupList!.map((x) => x.toJson())),
    "workout_training_list": workoutTrainingList == null ? [] : List<dynamic>.from(workoutTrainingList!.map((x) => x.toJson())),
  };
}

class WarmupList {
  String? id;
  String? workoutId;
  String? clientId;
  String? clientName;
  String? masterWorkoutId;
  String? masterWorkoutName;
  String? sets;
  String? repeatNo;
  String? repeatTime;
  String? status;
  String? deleteStatus;

  WarmupList({
    this.id,
    this.workoutId,
    this.clientId,
    this.clientName,
    this.masterWorkoutId,
    this.masterWorkoutName,
    this.sets,
    this.repeatNo,
    this.repeatTime,
    this.status,
    this.deleteStatus,
  });

  factory WarmupList.fromJson(Map<String, dynamic> json) => WarmupList(
    id: json["id"],
    workoutId: json["workout_id"],
    clientId: json["client_id"],
    clientName: json["client_name"],
    masterWorkoutId: json["master_workout_id"],
    masterWorkoutName: json["master_workout_name"],
    sets: json["sets"],
    repeatNo: json["repeat_no"],
    repeatTime: json["repeat_time"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workout_id": workoutId,
    "client_id": clientId,
    "client_name": clientName,
    "master_workout_id": masterWorkoutId,
    "master_workout_name": masterWorkoutName,
    "sets": sets,
    "repeat_no": repeatNo,
    "repeat_time": repeatTime,
    "status": status,
    "delete_status": deleteStatus,
  };
}

class WorkoutTrainingList {
  String? workoutTrainingName;
  String? day;
  String? status;
  String? deleteStatus;
  List<WorkoutTrainingCategory>? workoutTrainingCategory;

  WorkoutTrainingList({
    this.workoutTrainingName,
    this.day,
    this.status,
    this.deleteStatus,
    this.workoutTrainingCategory,
  });

  factory WorkoutTrainingList.fromJson(Map<String, dynamic> json) => WorkoutTrainingList(
    workoutTrainingName: json["workout_training_name"],
    day: json["day"],
    status: json["status"],
    deleteStatus: json["delete_status"],
    workoutTrainingCategory: json["workout_training_category"] == null ? [] : List<WorkoutTrainingCategory>.from(json["workout_training_category"]!.map((x) => WorkoutTrainingCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "workout_training_name": workoutTrainingName,
    "day": day,
    "status": status,
    "delete_status": deleteStatus,
    "workout_training_category": workoutTrainingCategory == null ? [] : List<dynamic>.from(workoutTrainingCategory!.map((x) => x.toJson())),
  };
}

class WorkoutTrainingCategory {
  String? workoutTrainingCategoryId;
  String? workoutTrainingCategoryName;
  List<WorkoutTrainingSubCategory>? workoutTrainingSubCategory;

  WorkoutTrainingCategory({
    this.workoutTrainingCategoryId,
    this.workoutTrainingCategoryName,
    this.workoutTrainingSubCategory,
  });

  factory WorkoutTrainingCategory.fromJson(Map<String, dynamic> json) => WorkoutTrainingCategory(
    workoutTrainingCategoryId: json["workout_training_category_id"],
    workoutTrainingCategoryName: json["workout_training_category_name"],
    workoutTrainingSubCategory: json["workout_training_sub_category"] == null ? [] : List<WorkoutTrainingSubCategory>.from(json["workout_training_sub_category"]!.map((x) => WorkoutTrainingSubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "workout_training_category_id": workoutTrainingCategoryId,
    "workout_training_category_name": workoutTrainingCategoryName,
    "workout_training_sub_category": workoutTrainingSubCategory == null ? [] : List<dynamic>.from(workoutTrainingSubCategory!.map((x) => x.toJson())),
  };
}

class WorkoutTrainingSubCategory {
  String? workoutDetailName;
  String? sets;
  String? repeatNo;
  String? repeatTime;
  String? remarks;
  String? status;
  String? deleteStatus;
  List<WorkoutDetailVideoList>? workoutDetailVideoList;

  WorkoutTrainingSubCategory({
    this.workoutDetailName,
    this.sets,
    this.repeatNo,
    this.repeatTime,
    this.remarks,
    this.status,
    this.deleteStatus,
    this.workoutDetailVideoList,
  });

  factory WorkoutTrainingSubCategory.fromJson(Map<String, dynamic> json) => WorkoutTrainingSubCategory(
    workoutDetailName: json["workout_detail_name"],
    sets: json["sets"],
    repeatNo: json["repeat_no"],
    repeatTime: json["repeat_time"],
    remarks: json["remarks"],
    status: json["status"],
    deleteStatus: json["delete_status"],
    workoutDetailVideoList: json["workout_detail_video_list"] == null ? [] : List<WorkoutDetailVideoList>.from(json["workout_detail_video_list"]!.map((x) => WorkoutDetailVideoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "workout_detail_name": workoutDetailName,
    "sets": sets,
    "repeat_no": repeatNo,
    "repeat_time": repeatTime,
    "remarks": remarks,
    "status": status,
    "delete_status": deleteStatus,
    "workout_detail_video_list": workoutDetailVideoList == null ? [] : List<dynamic>.from(workoutDetailVideoList!.map((x) => x.toJson())),
  };
}

class WorkoutDetailVideoList {
  String? video;
  String? sortOrder;
  String? remarks;
  String? status;
  String? deleteStatus;

  WorkoutDetailVideoList({
    this.video,
    this.sortOrder,
    this.remarks,
    this.status,
    this.deleteStatus,
  });

  factory WorkoutDetailVideoList.fromJson(Map<String, dynamic> json) => WorkoutDetailVideoList(
    video: json["video"],
    sortOrder: json["sort_order"],
    remarks: json["remarks"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "video": video,
    "sort_order": sortOrder,
    "remarks": remarks,
    "status": status,
    "delete_status": deleteStatus,
  };
}
