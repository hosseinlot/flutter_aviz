import 'package:aviz_app/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static void generateInitSettings() async {
    final SharedPreferences _sharedPreferences = locator.get();
    if (_sharedPreferences.containsKey('isFirstRun') == false) {
      await _sharedPreferences.setBool('showHotAviz', true);
      await _sharedPreferences.setBool('showAvizAlert', true);
      await _sharedPreferences.setBool('showSeperateWidgets', false);
      await _sharedPreferences.setBool('showPhoneNumber', true);
      await _sharedPreferences.setBool('isFirstRun', false);
    }
  }

  static bool isFirstRun() {
    final SharedPreferences _sharedPreferences = locator.get();
    return _sharedPreferences.containsKey('isFirstRun') ? false : true;
  }

  static Map<String, dynamic> loadSettings() {
    final SharedPreferences _sharedPreferences = locator.get();
    final Map<String, dynamic> settings = {};
    for (final key in _sharedPreferences.getKeys()) {
      settings[key] = _sharedPreferences.get(key);
    }
    return settings;
  }

  static void saveSettings(String key, dynamic value) async {
    final SharedPreferences _sharedPreferences = locator.get();

    switch (value.runtimeType) {
      case String:
        await _sharedPreferences.setString(key, value as String);
        break;
      case int:
        await _sharedPreferences.setInt(key, value as int);
        break;
      case bool:
        await _sharedPreferences.setBool(key, value as bool);
        break;
      case double:
        await _sharedPreferences.setDouble(key, value as double);
        break;
      default:
        // Handle other data types if needed
        break;
    }
  }
}
