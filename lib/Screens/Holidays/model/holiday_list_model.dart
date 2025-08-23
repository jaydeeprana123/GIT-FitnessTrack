// To parse this JSON data, do
//
//     final holidayListModel = holidayListModelFromJson(jsonString);

import 'dart:convert';

HolidayListModel holidayListModelFromJson(String str) => HolidayListModel.fromJson(json.decode(str));

String holidayListModelToJson(HolidayListModel data) => json.encode(data.toJson());

class HolidayListModel {
  bool? status;
  String? message;
  List<HolidayData>? data;

  HolidayListModel({
    this.status,
    this.message,
    this.data,
  });

  factory HolidayListModel.fromJson(Map<String, dynamic> json) => HolidayListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<HolidayData>.from(json["data"]!.map((x) => HolidayData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HolidayData {
  String? id;
  String? year;
  DateTime? date;
  String? name;

  HolidayData({
    this.id,
    this.year,
    this.date,
    this.name,
  });

  factory HolidayData.fromJson(Map<String, dynamic> json) => HolidayData(
    id: json["id"],
    year: json["year"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "year": year,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "name": name,
  };
}
