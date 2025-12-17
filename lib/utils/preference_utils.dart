import 'dart:convert';
import 'dart:isolate';

import 'package:fitness_track/Screens/Dashboard/model/dashboard_counter_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Authentication/Login/model/customer_login_response_model.dart';
import '../Screens/Authentication/Login/model/employee_login_response_model.dart';

// Created by Vrusti Patel
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefNew {
  MySharedPrefNew._internal();
  static final MySharedPrefNew _instance = MySharedPrefNew._internal();

  factory MySharedPrefNew() => _instance;

  static SharedPreferences? _prefs;
  static bool _initialized = false;

  /// MUST be called once from UI isolate (after runApp)
  static Future<void> init() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  /// Internal safety check
  bool get _isReady => _prefs != null;

  // ---------------- BASIC ----------------

  Future<void> setString(String key, String value) async {
    if (!_isReady) return;
    await _prefs!.setString(key, value);
  }

  String getString(String key) {
    if (!_isReady) return "";
    return _prefs!.getString(key) ?? "";
  }

  Future<void> setBool(String key, bool value) async {
    if (!_isReady) return;
    await _prefs!.setBool(key, value);
  }

  bool getBool(String key) {
    if (!_isReady) return false;
    return _prefs!.getBool(key) ?? false;
  }

  // ---------------- CLEAR ----------------

  Future<void> clearKey(String key) async {
    if (!_isReady) return;
    await _prefs!.remove(key);
  }

  Future<void> clearAll() async {
    if (!_isReady) return;
    await _prefs!.clear();
  }

  // ---------------- MODELS ----------------

  Future<void> setCustomerLoginModel(
      CustomerLoginResponseModel model, String key) async {
    if (!_isReady) return;
    await _prefs!.setString(key, jsonEncode(model.toJson()));
  }

  CustomerLoginResponseModel? getCustomerLoginModel(String key) {
    if (!_isReady) return null;
    final data = _prefs!.getString(key);
    if (data == null || data.isEmpty) return null;
    return CustomerLoginResponseModel.fromJson(jsonDecode(data));
  }

  Future<void> setEmployeeLoginModel(
      EmployeeLoginResponseModel model, String key) async {
    if (!_isReady) return;
    await _prefs!.setString(key, jsonEncode(model.toJson()));
  }

  EmployeeLoginResponseModel? getEmployeeLoginModel(String key) {
    if (!_isReady) return null;
    final data = _prefs!.getString(key);
    if (data == null || data.isEmpty) return null;
    return EmployeeLoginResponseModel.fromJson(jsonDecode(data));
  }

  // ---------------- DASHBOARD ----------------

  Future<void> setDashboardModel(
      DashboardData model, String key) async {
    if (!_isReady) return;
    await _prefs!.setString(key, jsonEncode(model.toJson()));
  }

  DashboardData? getDashboardData(String key) {
    if (!_isReady) return null;
    final data = _prefs!.getString(key);
    if (data == null || data.isEmpty) return null;
    return DashboardData.fromJson(jsonDecode(data));
  }

  // ---------------- ACCESS TOKEN ----------------

  Future<void> setAccessToken(String token, String key) async {
    if (!_isReady) return;
    await _prefs!.setString(key, token);
  }

  String getAccessToken(String key) {
    if (!_isReady) return "";
    return _prefs!.getString(key) ?? "";
  }
}



