// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

EmployeeLoginResponseModel loginResponseModelFromJson(String str) => EmployeeLoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(EmployeeLoginResponseModel data) => json.encode(data.toJson());

class EmployeeLoginResponseModel {
  bool? status;
  String? message;
  List<EmployeeLoginData>? data;
  String? accessToken;

  EmployeeLoginResponseModel({
    this.status,
    this.message,
    this.data,
    this.accessToken,
  });

  factory EmployeeLoginResponseModel.fromJson(Map<String, dynamic> json) => EmployeeLoginResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<EmployeeLoginData>.from(json["data"]!.map((x) => EmployeeLoginData.fromJson(x))),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "access_token": accessToken,
  };
}

class EmployeeLoginData {
  String? id;
  String? empCode;
  String? name;
  String? email;
  String? mobile;
  String? photo;
  String? designationId;
  String? designationName;
  String? regularShiftApply;
  String? branchId;
  String? branchName;
  String? aadharCardNo;
  String? aadharCardPic;
  String? signature;
  String? address;
  String? stateId;
  String? stateName;
  String? cityId;
  String? cityName;
  String? areaId;
  String? areaName;
  String? pincode;
  String? remarks;
  String? basicSalary;
  String? sundayAmt;
  String? overTimeAmt;
  String? personalTrainingAmt;
  String? absentAmt;
  String? lateMinAmt;
  String? currentShift;
  dynamic joiningDate;
  String? bankAccNo;
  String? bankName;
  String? ifscCode;
  String? accountType;
  String? oldCancelledCheqPhoto;
  String? upiId;
  dynamic leaveManagment;
  String? termCondition;
  String? termsAndCondition;
  String? termsAndConditionAccept;
  String? termsAndConditionData;
  String? status;
  String? deleteStatus;

  EmployeeLoginData({
    this.id,
    this.empCode,
    this.name,
    this.email,
    this.mobile,
    this.photo,
    this.designationId,
    this.designationName,
    this.regularShiftApply,
    this.branchId,
    this.branchName,
    this.aadharCardNo,
    this.aadharCardPic,
    this.signature,
    this.address,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.pincode,
    this.remarks,
    this.basicSalary,
    this.sundayAmt,
    this.overTimeAmt,
    this.personalTrainingAmt,
    this.absentAmt,
    this.lateMinAmt,
    this.currentShift,
    this.joiningDate,
    this.bankAccNo,
    this.bankName,
    this.ifscCode,
    this.accountType,
    this.oldCancelledCheqPhoto,
    this.upiId,
    this.leaveManagment,
    this.termCondition,
    this.termsAndCondition,
    this.termsAndConditionAccept,
    this.termsAndConditionData,
    this.status,
    this.deleteStatus,
  });

  factory EmployeeLoginData.fromJson(Map<String, dynamic> json) => EmployeeLoginData(
    id: json["id"],
    empCode: json["emp_code"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    photo: json["photo"],
    designationId: json["designation_id"],
    designationName: json["designation_name"],
    regularShiftApply:json["regular_shift_apply"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    aadharCardNo: json["aadhar_card_no"],
    aadharCardPic: json["aadhar_card_pic"],
    signature: json["signature"],
    address: json["address"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    areaId: json["area_id"],
    areaName: json["area_name"],
    pincode: json["pincode"],
    remarks: json["remarks"],
    basicSalary: json["basic_salary"],
    sundayAmt: json["sunday_amt"],
    overTimeAmt: json["over_time_amt"],
    personalTrainingAmt: json["personal_training_amt"],
    absentAmt: json["absent_amt"],
    lateMinAmt: json["late_min_amt"],
    currentShift: json["current_shift"],
    joiningDate: json["joining_date"],
    bankAccNo: json["bank_acc_no"],
    bankName: json["bank_name"],
    ifscCode: json["ifsc_code"],
    accountType: json["account_type"],
    oldCancelledCheqPhoto: json["old_cancelled_cheq_photo"],
    upiId: json["upi_id"],
    leaveManagment: json["leave_managment"],
    termCondition: json["term_condition"],
    termsAndCondition: json["terms_and_condition"],
    termsAndConditionAccept: json["terms_and_condition_accept"],
    termsAndConditionData: json["terms_and_condition_data"],
    status: json["status"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_code": empCode,
    "name": name,
    "email": email,
    "mobile": mobile,
    "photo": photo,
    "designation_id": designationId,
    "designation_name": designationName,
    "regular_shift_apply" : regularShiftApply,
    "branch_id": branchId,
    "branch_name": branchName,
    "aadhar_card_no": aadharCardNo,
    "aadhar_card_pic": aadharCardPic,
    "signature": signature,
    "address": address,
    "state_id": stateId,
    "state_name": stateName,
    "city_id": cityId,
    "city_name": cityName,
    "area_id": areaId,
    "area_name": areaName,
    "pincode": pincode,
    "remarks": remarks,
    "basic_salary": basicSalary,
    "sunday_amt": sundayAmt,
    "over_time_amt": overTimeAmt,
    "personal_training_amt": personalTrainingAmt,
    "absent_amt": absentAmt,
    "late_min_amt": lateMinAmt,
    "current_shift": currentShift,
    "joining_date": joiningDate,
    "bank_acc_no": bankAccNo,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "account_type": accountType,
    "old_cancelled_cheq_photo": oldCancelledCheqPhoto,
    "upi_id": upiId,
    "leave_managment": leaveManagment,
    "term_condition": termCondition,
    "terms_and_condition": termsAndCondition,
    "terms_and_condition_accept": termsAndConditionAccept,
    "terms_and_condition_data": termsAndConditionData,
    "status": status,
    "delete_status": deleteStatus,
  };
}
