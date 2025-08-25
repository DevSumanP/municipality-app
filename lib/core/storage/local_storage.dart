import 'package:hive/hive.dart';

class LocalStorage {
  static Box? _box;

  /// Initialize Hive and open a box
  static Future<void> init({String boxName = 'localStorage'}) async {
    _box ??= await Hive.openBox(boxName);
  }

  Future<void> setString(String key, String value) async{
    final box = _box ?? await Hive.openBox('localStorage');
    return await box.put(key, value);
  }

  Future<String?> getString(String key) async{
    final box = _box ?? await Hive.openBox('localStorage');
    return box.get(key);
  }
  
  Future<void> setBool(String key, bool value) async {
    await _box?.put(key, value);
  }

  bool? getBool(String key) {
    return _box?.get(key);
  }

  Future<void> setInt(String key, int value) async {
    await _box?.put(key, value);
  }

  int? getInt(String key) {
    return _box?.get(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _box?.put(key, value);
  }

  double? getDouble(String key) {
    return _box?.get(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _box?.put(key, value);
  }

  List<String>? getStringList(String key) {
    return (_box?.get(key) as List?)?.cast<String>();
  }

  Future<void> remove(String key) async {
    await _box?.delete(key);
  }

  Future<void> clear() async {
    await _box?.clear();
  }

  bool containsKey(String key) {
    return _box?.containsKey(key) ?? false;
  }

  Set<String> getKeys() {
    return _box?.keys.cast<String>().toSet() ?? {};
  }
}