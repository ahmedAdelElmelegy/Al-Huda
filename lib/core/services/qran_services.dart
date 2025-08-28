import 'package:al_huda/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QranServices {
  static Future<void> setReaderName(String readerName) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(Constants.reader, readerName);
  }

  static Future<String?> getReaderName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(Constants.reader);
  }
}
