import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(key, value) ?? Future.value(false);
  }

  static bool getBool(String key, [bool defValue]) {
    return _prefsInstance.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  static String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setStringList(String key, [List<String> value]) async {
    var prefs = await _instance;
    return prefs?.setStringList(key, value) ?? Future.value(false);
  }

  static List<String> getStringList(String key, [List<String> defValue]) {
    return _prefsInstance.getStringList(key) ?? defValue ?? false;
  }

  static Future<bool> remove(String key) async {
    var prefs = await _instance;
    return prefs?.remove(key) ?? Future.value(false);
  }
}
