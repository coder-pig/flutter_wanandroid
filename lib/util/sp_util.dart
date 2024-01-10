import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferencesUtil? _instance;
  late final SharedPreferences _preferences;

  // 私有化构造方法
  SharedPreferencesUtil._(this._preferences);

  // 返回实例
  static Future<SharedPreferencesUtil> getInstance() async {
    if (_instance == null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _instance = SharedPreferencesUtil._(preferences);
    }
    return _instance!;
  }

  Future<bool> putString(String key, String value) => _preferences.setString(key, value);

  Future<bool> putStringList(String key, List<String> value) => _preferences.setStringList(key, value);

  Future<bool> putInt(String key, int value) => _preferences.setInt(key, value);

  Future<bool> putDouble(String key, double value) => _preferences.setDouble(key, value);

  Future<bool> putBool(String key, bool value) => _preferences.setBool(key, value);

  String getString(String key, {String defaultValue = ""}) => _preferences.getString(key) ?? defaultValue;

  List<String> getStringList(String key, {List<String> defaultValue = const []}) =>
      _preferences.getStringList(key) ?? defaultValue;

  int getInt(String key, {int defaultValue = 0}) => _preferences.getInt(key) ?? defaultValue;

  double getDouble(String key, {double defaultValue = 0.0}) => _preferences.getDouble(key) ?? defaultValue;

  bool getBool(String key, {bool defaultValue = false}) => _preferences.getBool(key) ?? defaultValue;

  bool containsKey(String key) => _preferences.containsKey(key);

  Future<bool> remove(String key) => _preferences.remove(key);

  Future<bool> clear() => _preferences.clear();
}
