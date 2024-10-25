import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static final CacheHelper _instance = CacheHelper._();
  CacheHelper._();
  factory CacheHelper() => _instance;
  static SharedPreferences? sharedPreferences;
  static Future<void> init() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
  }

  // Method to get data from SharedPreferences by key
  static dynamic getData(String key) {
    debugPrint('CacheHelper : getData with key : $key');
    return sharedPreferences?.get(key);
  }

  // Method to save data in SharedPreferences
  static Future<bool?> saveData(String key, dynamic value) async {
    debugPrint("CacheHelper : saveData with key : $key and value : $value");
    if (sharedPreferences == null) return null;

    bool success = false;
    if (value is String) {
      success = await sharedPreferences!.setString(key, value);
    } else if (value is int) {
      success = await sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      success = await sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      success = await sharedPreferences!.setDouble(key, value);
    } else {
      return null;
    }
    return success;
  }

  // Method to remove data from SharedPreferences by key
  static Future<bool?> removeData(String key) async {
    debugPrint('CacheHelper : removeData with key : $key');
    if (sharedPreferences == null) return null;
    return await sharedPreferences?.remove(key);
  }

  // Method to clear all data from SharedPreferences
  static Future<void> clearAllData() async {
    debugPrint('CacheHelper : all data has been cleared');
    await sharedPreferences?.clear();
  }
}
