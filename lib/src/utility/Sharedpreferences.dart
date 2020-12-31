import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _login = 'login';

  static Future<bool> clearAllPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(_login);
    return preferences.clear();
  }

  static Future<bool> clearPreference(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(key);
    return preferences.remove(key);
  }


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


  static Future<bool> setDoLogin(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_login, value);
  }

  static Future<String> getDoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_login) ?? '';
  }

}

