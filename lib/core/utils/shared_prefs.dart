// ignore_for_file: depend_on_referenced_packages

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static late SharedPreferences sharedPreferences;

  static Future sharedInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveToShard(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> saveBool(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool> isGuestSave(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool isGuest({required String key}) {
    return sharedPreferences.getBool(key) ?? false;
  }

  static String getFromShard({required String key}) {
    return sharedPreferences.getString(key) ?? '';
  }

  static Object removeFromShard({required String key}) {
    return sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
