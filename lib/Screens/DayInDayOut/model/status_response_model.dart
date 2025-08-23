// To parse this JSON data, do
//
//     final statusResponseModel = statusResponseModelFromJson(jsonString);

import 'dart:convert';

StatusResponseModel statusResponseModelFromJson(String str) => StatusResponseModel.fromJson(json.decode(str));

String statusResponseModelToJson(StatusResponseModel data) => json.encode(data.toJson());

class StatusResponseModel {
  dynamic status;
  String? message;
  List<dynamic>? data;

  StatusResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory StatusResponseModel.fromJson(Map<String, dynamic> json) => StatusResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
