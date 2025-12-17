import 'dart:convert';

import 'package:fitness_track/Screens/Dashboard/model/dashboard_counter_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Authentication/Login/model/customer_login_response_model.dart';
import '../Screens/Authentication/Login/model/employee_login_response_model.dart';




// Created by Vrusti Patel



class MySharedPref {
  static MySharedPref? classInstance;
  static SharedPreferences? preferences;

  static Future<MySharedPref?> getInstance() async {
    classInstance ??= MySharedPref();
    preferences ??= await SharedPreferences.getInstance();
    return classInstance;
  }

  // ---------------- BASIC ----------------

  _getFromDisk(String key) async {
    var value = preferences?.get(key);
    print("Value Model got... .... $value");
    return value;
  }

  Future<void> setString(String key, String content) async {
    print("Value Set ::::::$content");
    await preferences?.setString(key, content);
  }

  Future<void> setBool(String key, bool value) async {
    print("Value set ::::::$value");
    await preferences?.setBool(key, value);
  }

  getStringValue(String key) async {
    String stringValue = preferences?.getString(key) ?? "";
    print("Value get ::::::$stringValue");
    return stringValue;
  }

  getBoolValue(String key) async {
    bool boolVal = preferences?.getBool(key) ?? false;
    print("Value get ::::::$boolVal");
    return boolVal;
  }

  // ---------------- CLEAR ----------------

  Future<void> clearData(String key) async {
    await preferences?.remove(key);
  }

  Future<void> clear() async {
    await preferences?.clear();
  }

  // ---------------- MODELS ----------------

  setCustomerLoginModel(CustomerLoginResponseModel model, String key) async {
    print("Value set model ::::::${model.data?.first ?? ""}");
    await preferences?.setString(key, json.encode(model.toJson()));
  }

  Future<CustomerLoginResponseModel?> getCustomerLoginModel(String key) async {
    var myJson = preferences?.getString(key);
    if (myJson == null) return null;
    return CustomerLoginResponseModel.fromJson(json.decode(myJson));
  }

  setEmployeeLoginModel(EmployeeLoginResponseModel model, String key) async {
    print("Value set model ::::::${model.data?.first ?? ""}");
    await preferences?.setString(key, json.encode(model.toJson()));
  }

  Future<EmployeeLoginResponseModel?> getEmployeeLoginModel(String key) async {
    var myJson = preferences?.getString(key);
    if (myJson == null) return null;
    return EmployeeLoginResponseModel.fromJson(json.decode(myJson));
  }

  setDashboardModel(DashboardData model, String key) async {
    await preferences?.setString(key, json.encode(model.toJson()));
  }

  Future<DashboardData?> getDashboardData(String key) async {
    var myJson = preferences?.getString(key);
    if (myJson == null) return null;
    return DashboardData.fromJson(json.decode(myJson));
  }

  setAccessToken(String accessToken, String key) async {
    await preferences?.setString(key, accessToken);
  }

  Future<String> getAccessToken(String key) async {
    return preferences?.getString(key) ?? "";
  }
}

