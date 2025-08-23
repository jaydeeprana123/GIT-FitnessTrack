// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
 bool? status;
 String? message;
 List<AboutUsData>? data;

 AboutUsModel({
  this.status,
  this.message,
  this.data,
 });

 factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
  status: json["status"],
  message: json["message"],
  data: json["data"] == null ? [] : List<AboutUsData>.from(json["data"]!.map((x) => AboutUsData.fromJson(x))),
 );

 Map<String, dynamic> toJson() => {
  "status": status,
  "message": message,
  "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
 };
}

class AboutUsData {
 String? id;
 String? pageName;
 String? description;

 AboutUsData({
  this.id,
  this.pageName,
  this.description,
 });

 factory AboutUsData.fromJson(Map<String, dynamic> json) => AboutUsData(
  id: json["id"],
  pageName: json["page_name"],
  description: json["description"],
 );

 Map<String, dynamic> toJson() => {
  "id": id,
  "page_name": pageName,
  "description": description,
 };
}
