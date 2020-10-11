import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> setValueCheckedBox(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future<bool> getValueChecdBox(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ??  false;
  }

  static Future<bool> setValueChecked(String key, String val) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key,val);
  }

  static Future<String> getValueChecked(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? '';
  }
}

