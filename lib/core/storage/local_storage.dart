import 'package:hive/hive.dart';

class LocalStorage {
  static Box? _box;

  /// Initialize Hive and open a box
  static Future<void> init({String boxName = 'localStorage'}) async {
    _box ??= await Hive.openBox(boxName);
  }

  /// Helper method to ensure box is available
  Future<Box> get box async {
    if (_box == null) {
      _box = await Hive.openBox('localStorage');
    }
    return _box!;
  }

  Future<void> setString(String key, String value) async {
    final boxInstance = await box;
    return await boxInstance.put(key, value);
  }

  Future<String?> getString(String key) async {
    final boxInstance = await box;
    return boxInstance.get(key);
  }

  Future<void> setBool(String key, bool value) async {
    final boxInstance = await box;
    await boxInstance.put(key, value);
  }

  Future<bool?> getBool(String key) async {
    final boxInstance = await box;
    return boxInstance.get(key);
  }

  Future<void> setInt(String key, int value) async {
    final boxInstance = await box;
    await boxInstance.put(key, value);
  }

  Future<int?> getInt(String key) async {
    final boxInstance = await box;
    return boxInstance.get(key);
  }

  Future<void> setDouble(String key, double value) async {
    final boxInstance = await box;
    await boxInstance.put(key, value);
  }

  Future<double?> getDouble(String key) async {
    final boxInstance = await box;
    return boxInstance.get(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    final boxInstance = await box;
    await boxInstance.put(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    final boxInstance = await box;
    return (boxInstance.get(key) as List?)?.cast<String>();
  }

  Future<void> remove(String key) async {
    try {
      final boxInstance = await box;
      await boxInstance.delete(key);
      print('Removed key "$key" from Hive storage');
      
      // Verify removal
      final checkValue = boxInstance.get(key);
      if (checkValue == null) {
        print('Key "$key" successfully removed');
      } else {
        print('Key "$key" still exists with value: $checkValue');
      }
    } catch (e) {
      print('Error removing key "$key": $e');
      rethrow;
    }
  }

  Future<void> clear() async {
    try {
      final boxInstance = await box;
      await boxInstance.clear();
      print('Cleared all Hive storage');
    } catch (e) {
      print('Error clearing storage: $e');
      rethrow;
    }
  }

  Future<bool> containsKey(String key) async {
    final boxInstance = await box;
    return boxInstance.containsKey(key);
  }

  Future<Set<String>> getKeys() async {
    final boxInstance = await box;
    return boxInstance.keys.cast<String>().toSet();
  }
}