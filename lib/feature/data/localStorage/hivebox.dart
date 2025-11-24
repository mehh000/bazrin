import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String boxName = 'bazrin';
  static Box? _box;

  /// Initialize Hive and open the box
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  /// Get the box
  static Box get box {
    if (_box == null) {
      throw Exception(
        'Hive box not initialized. Call LocalStorage.init() first.',
      );
    }
    return _box!;
  }
}
