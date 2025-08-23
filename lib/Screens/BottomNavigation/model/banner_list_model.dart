// To parse this JSON data, do
//
//     final bannerListModel = bannerListModelFromJson(jsonString);

import 'dart:convert';

BannerListModel bannerListModelFromJson(String str) => BannerListModel.fromJson(json.decode(str));

String bannerListModelToJson(BannerListModel data) => json.encode(data.toJson());

class BannerListModel {
 BannerListModel({
  this.success,
  this.statusCode,
  this.message,
  this.data,
 });

 bool? success;
 int? statusCode;
 String? message;
 List<Banners>? data;

 factory BannerListModel.fromJson(Map<String, dynamic> json) => BannerListModel(
  success: json["success"],
  statusCode: json["status_code"],
  message: json["message"],
  data: List<Banners>.from(json["data"].map((x) => Banners.fromJson(x))),
 );

 Map<String, dynamic> toJson() => {
  "success": success,
  "status_code": statusCode,
  "message": message,
  "data": List<dynamic>.from(data!.map((x) => x.toJson())),
 };
}

class Banners {
 Banners({
  this.id,
  this.promotionType,
  this.startDate,
  this.endDate,
  this.image,
  this.duration,
  this.facebook,
  this.instagram,
  this.linkedin,
  this.isLive,
  this.createdAt,
  this.updatedAt,
  this.deletedAt,
 });

 int? id;
 String? promotionType;
 DateTime? startDate;
 DateTime? endDate;
 String? image;
 String? duration;
 dynamic facebook;
 dynamic instagram;
 dynamic linkedin;
 int? isLive;
 DateTime? createdAt;
 DateTime? updatedAt;
 dynamic deletedAt;

 factory Banners.fromJson(Map<String, dynamic> json) => Banners(
  id: json["id"],
  promotionType: json["promotion_type"],
  startDate: DateTime.parse(json["start_date"]),
  endDate: DateTime.parse(json["end_date"]),
  image: json["image"],
  duration: json["duration"],
  facebook: json["facebook"],
  instagram: json["instagram"],
  linkedin: json["linkedin"],
  isLive: json["is_live"],
  createdAt: DateTime.parse(json["created_at"]),
  updatedAt: DateTime.parse(json["updated_at"]),
  deletedAt: json["deleted_at"],
 );

 Map<String, dynamic> toJson() => {
  "id": id,
  "promotion_type": promotionType,
  "start_date": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
  "end_date": "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
  "image": image,
  "duration": duration,
  "facebook": facebook,
  "instagram": instagram,
  "linkedin": linkedin,
  "is_live": isLive,
  "created_at": createdAt?.toIso8601String(),
  "updated_at": updatedAt?.toIso8601String(),
  "deleted_at": deletedAt,
 };
}
