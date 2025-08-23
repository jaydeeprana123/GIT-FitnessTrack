import 'dart:convert';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  BaseModel({this.status, this.message, this.success, this.error});

  bool? status;
  String? message;
  String? success;
  String? error;

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "error": error,
      };
}
