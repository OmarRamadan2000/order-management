import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  final SharedPreferences sharedPreferences;

  SharedPrefManager(this.sharedPreferences);

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeAllData() async {
    return await sharedPreferences.clear();
  }

  Future<bool> remove(String key) async {
    return await sharedPreferences.remove(key);
  }
}
