import 'dart:convert';

import 'package:fitness_track/Screens/Dashboard/model/dashboard_counter_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _getFromDisk(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.get(key);
    print("Value Model got... .... $value");
    return value;
  }

  Future<void> setString(String key, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Value Set ::::::$content");
    prefs.setString(key, content);
  }

  Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Value set ::::::$value");
    prefs.setBool(key, value);
  }

  getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(key) ?? "";
    print("Value set ::::::$stringValue");
    return stringValue;
  }

  getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? boolVal = prefs.getBool(key);
    print("Value get ::::::$boolVal");
    boolVal ??= false;
    return boolVal;
  }

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

  /// Used to save user's information
  setCustomerLoginModel(CustomerLoginResponseModel model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    print("Value set model ::::::${model.data?.first ?? ""}");
    print("Value set model name ::::::${model.data?.last ?? ""}");
    prefs.setString(key, json.encode(model.toJson()));
  }

  /// Used to get user's information
  Future<CustomerLoginResponseModel?> getCustomerLoginModel(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    var myJson = prefs.getString(key);
    if (myJson == null) {
      return null;
    }
    return CustomerLoginResponseModel.fromJson(json.decode(myJson));
  }

  /// Used to save user's information
  setEmployeeLoginModel(EmployeeLoginResponseModel model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    print("Value set model ::::::${model.data?.first ?? ""}");
    print("Value set model name ::::::${model.data?.last ?? ""}");
    prefs.setString(key, json.encode(model.toJson()));
  }

  /// Used to get user's information
  Future<EmployeeLoginResponseModel?> getEmployeeLoginModel(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    var myJson = prefs.getString(key);
    if (myJson == null) {
      return null;
    }
    return EmployeeLoginResponseModel.fromJson(json.decode(myJson));
  }

  /// Used to save user's information
  setDashboardModel(DashboardData model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    prefs.setString(key, json.encode(model.toJson()));
  }

  /// Used to get user's information
  Future<DashboardData?> getDashboardData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    var myJson = prefs.getString(key);
    if (myJson == null) {
      return null;
    }
    return DashboardData.fromJson(json.decode(myJson));
  }

  /// set access token for kundli
  setAccessToken(String accessToken, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    // printData("cart model.toJson()", cartItemList.toJson().toString());
    prefs.setString(key, accessToken);
  }

  ///  get access token
  Future<String> getAccessToken(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    var accessToken = prefs.getString(key);
    if (accessToken == null) {
      return "";
    } else {
      return accessToken;
    }
  }
}
