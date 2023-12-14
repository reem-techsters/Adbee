import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProv extends ChangeNotifier {
  Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic savedresponse = prefs.getString(key);
    return savedresponse;
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool savedresponse = prefs.getBool(key) ?? false;
    return savedresponse;
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> updateString(String key, String newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, newValue);
  }

  Future<void> deleteDataFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
