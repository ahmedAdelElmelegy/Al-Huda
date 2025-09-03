import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static Future<void> setValue(String value, String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  static Future<String?> getValue(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  static Future<void> setDoubleValue(double value, String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setDouble(key, value);
  }

  static Future<double?> getDoubleValue(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }

  static Future<void> setBool(bool value, String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }
}
