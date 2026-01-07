import 'dart:convert';

import 'package:fitness_track/Screens/Dashboard/model/dashboard_counter_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CommonWidgets/common_widget.dart';
import '../Screens/Authentication/Login/model/customer_login_response_model.dart';
import '../Screens/Authentication/Login/model/employee_login_response_model.dart';

// Created by Vrusti Patel
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    printData(
        runtimeType.toString(), "Value Set ::::::$key :::::::::: $content");
    prefs.setString(key, content);
  }

  Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    printData(runtimeType.toString(), "Value set ::::::$value");
    prefs.setBool(key, value);
  }

  getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(key) ?? "";
    printData(
        runtimeType.toString(), "Value set ::::::$key :::::::::: $stringValue");
    return stringValue;
  }

  getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? boolVal = prefs.getBool(key);
    printData(runtimeType.toString(), "Value get ::::::$boolVal");
    return boolVal;
  }

  // ---------------- CLEAR ----------------

  // It clears preference data by unique key name
  Future<void> clearData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    prefs.remove(key);
  }

  // It clears preference whole data
  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    prefs.clear();
  }
  // ---------------- MODELS ----------------

  setCustomerLoginModel(CustomerLoginResponseModel model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(model.toJson()));
  }

  Future<CustomerLoginResponseModel?> getCustomerLoginModel(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    var myJson = prefs.getString(key);

    printData(runtimeType.toString(), "myJson " + myJson.toString());

    if (myJson == null) {
      return null;
    }
    return CustomerLoginResponseModel.fromJson(json.decode(myJson));
  }

  setEmployeeLoginModel(EmployeeLoginResponseModel model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(model.toJson()));
  }

  Future<EmployeeLoginResponseModel?> getEmployeeLoginModel(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    var myJson = prefs.getString(key);

    printData(runtimeType.toString(), "myJson " + myJson.toString());

    if (myJson == null) {
      return null;
    }
    return EmployeeLoginResponseModel.fromJson(json.decode(myJson));
  }

  setDashboardModel(DashboardData model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(model.toJson()));
  }

  Future<DashboardData?> getDashboardData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myJson = prefs.getString(key);
    if (myJson == null) return null;
    return DashboardData.fromJson(json.decode(myJson));
  }
}
