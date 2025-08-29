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
}
