// To parse this JSON data, do
//
//     final customerLoginResponseModel = customerLoginResponseModelFromJson(jsonString);

import 'dart:convert';

CustomerLoginResponseModel customerLoginResponseModelFromJson(String str) => CustomerLoginResponseModel.fromJson(json.decode(str));

String customerLoginResponseModelToJson(CustomerLoginResponseModel data) => json.encode(data.toJson());

class CustomerLoginResponseModel {
  bool? status;
  String? message;
  List<CustomerLoginData>? data;
  String? accessToken;

  CustomerLoginResponseModel({
    this.status,
    this.message,
    this.data,
    this.accessToken,
  });

  factory CustomerLoginResponseModel.fromJson(Map<String, dynamic> json) => CustomerLoginResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CustomerLoginData>.from(json["data"]!.map((x) => CustomerLoginData.fromJson(x))),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "access_token": accessToken,
  };
}

class CustomerLoginData {
  String? id;
  String? clientCode;
  String? branchId;
  String? branchName;
  String? trainerId;
  String? programmeId;
  String? programmeName;
  String? name;
  String? age;
  String? gender;
  String? mobile;
  String? email;
  String? photo;
  String? dob;
  String? occupation;
  String? aadharCardNo;
  String? username;
  String? password;
  String? passwordText;
  String? address;
  String? stateId;
  String? stateName;
  String? cityId;
  String? cityName;
  String? areaId;
  String? areaName;
  String? pincode;
  String? emergencyPersonName;
  dynamic emergencyPersonPhone;
  String? problem;
  String? medicine;
  String? status;
  String? deleteStatus;

  CustomerLoginData({
    this.id,
    this.clientCode,
    this.branchId,
    this.branchName,
    this.trainerId,
    this.programmeId,
    this.programmeName,
    this.name,
    this.age,
    this.gender,
    this.mobile,
    this.email,
    this.photo,
    this.dob,
    this.occupation,
    this.aadharCardNo,
    this.username,
    this.password,
    this.passwordText,
    this.address,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.pincode,
    this.emergencyPersonName,
    this.emergencyPersonPhone,
    this.problem,
    this.medicine,
    this.status,
    this.deleteStatus,
  });

  factory CustomerLoginData.fromJson(Map<String, dynamic> json) => CustomerLoginData(
    id: json["id"],
    clientCode: json["client_code"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    trainerId: json["trainer_id"],
    programmeId: json["programme_id"],
    programmeName: json["programme_name"],
    name: json["name"],
    age: json["age"],
    gender: json["gender"],
    mobile: json["mobile"],
    email: json["email"],
    photo: json["photo"],
    dob: json["dob"],
    occupation: json["occupation"],
    aadharCardNo: json["aadhar_card_no"],
    username: json["username"],
    password: json["password"],
    passwordText: json["password_text"],
    address: json["address"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    areaId: json["area_id"],
    areaName: json["area_name"],
    pincode: json["pincode"],
    emergencyPersonName: json["emergency_person_name"],
    emergencyPersonPhone: json["emergency_person_phone\t"],
    problem: json["problem"],
    medicine: json["medicine"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_code": clientCode,
    "branch_id": branchId,
    "branch_name": branchName,
    "trainer_id": trainerId,
    "programme_id": programmeId,
    "programme_name": programmeName,
    "name": name,
    "age": age,
    "gender": gender,
    "mobile": mobile,
    "email": email,
    "photo": photo,
    "dob": dob,
    "occupation": occupation,
    "aadhar_card_no": aadharCardNo,
    "username": username,
    "password": password,
    "password_text": passwordText,
    "address": address,
    "state_id": stateId,
    "state_name": stateName,
    "city_id": cityId,
    "city_name": cityName,
    "area_id": areaId,
    "area_name": areaName,
    "pincode": pincode,
    "emergency_person_name": emergencyPersonName,
    "emergency_person_phone\t": emergencyPersonPhone,
    "problem": problem,
    "medicine": medicine,
    "status": status,
    "delete_status": deleteStatus,
  };
}
