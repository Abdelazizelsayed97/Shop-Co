import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as Directory;

class HiveStorageService {
  static final HiveStorageService _service = HiveStorageService();

  static HiveStorageService get service => _service;

  static Future<void> init() async {
    var path = Directory.current;
    Hive.init(path);
  }

  /// Save a model as JSON string using a key
  Future<void> saveModel<T>({
    required String boxName,
    required String key,
    required T model,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    final box = await Hive.openBox(boxName);
    final jsonString = jsonEncode(toJson(model));
    await box.put(key, jsonString);
  }

  /// Read a model by key
  Future<T?> getModel<T>({
    required String boxName,
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final box = await Hive.openBox(boxName);
    final jsonString = box.get(key);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    return fromJson(json);
  }

  /// Delete model by key
  Future<void> deleteModel({
    required String boxName,
    required String key,
  }) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }

  /// Clear entire box
  Future<void> clearBox(String boxName) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
