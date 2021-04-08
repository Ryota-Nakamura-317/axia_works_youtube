import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<String> getName() async {
    return _getString(PrefKeys.NAME);
  }

  static setName(String name) async {
    _setString(PrefKeys.NAME, name);
  }

  static Future<int> getAge() async {
    return _getInt(PrefKeys.AGE);
  }

  static setAge(int age) async {
    _setInt(PrefKeys.AGE, age);
  }

  static Future<String> getBirthday() async {
    return _getString(PrefKeys.BIRTHDAY);
  }

  static setBirthday(String birthday) async {
    _setString(PrefKeys.BIRTHDAY, birthday);
  }

  //String読み込み
  static Future<String> _getString(PrefKeys keys) async {
    final prefs = await _getPrefs();
    return prefs.getString(keys.toString());
  }

  //String書き込み
  static Future<void> _setString(PrefKeys keys, String value) async {
    final prefs = await _getPrefs();
    return prefs.setString(keys.toString(), value);
  }

  //int読み込み
  static Future<int> _getInt(PrefKeys keys) async {
    final prefs = await _getPrefs();
    return prefs.getInt(keys.toString());
  }

  //int書き込み
  static Future<void> _setInt(PrefKeys keys, int value) async {
    final prefs = await _getPrefs();
    return prefs.setInt(keys.toString(), value);
  }

  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }
}

enum PrefKeys {
  NAME,
  AGE,
  BIRTHDAY,
}
