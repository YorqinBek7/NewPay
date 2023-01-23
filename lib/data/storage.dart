import 'package:shared_preferences/shared_preferences.dart';

class NewPayStorage {
  static final NewPayStorage instance = NewPayStorage._();
  factory NewPayStorage() => instance;
  NewPayStorage._();
  late SharedPreferences sharedPref;

  void setString(String key, String value) => sharedPref.setString(key, value);

  void setBool(String key, bool value) => sharedPref.setBool(key, value);

  void setInt(String key, int value) => sharedPref.setInt(key, value);

  String getString(String key) => sharedPref.getString(key) ?? '';

  bool getBool(String key) => sharedPref.getBool(key) ?? false;

  int getInt(String key) => sharedPref.getInt(key) ?? 0;
}
