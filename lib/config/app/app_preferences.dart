import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/core/constants/language_constant.dart';
import 'package:spend_wise/core/constants/shared_preferences_keys.dart';

class AppPreferences {
  late SharedPreferences _sharedPreferences;
  AppPreferences(SharedPreferences sharedPreferences)
    : _sharedPreferences = sharedPreferences;
  setLanguage({String? languageCode}) {
    _sharedPreferences.setString(
      SharedPreferencesKeys.appLanguageKey,
      languageCode ?? LanguageConstant.en,
    );
  }

  String? getLanguage() {
    return _sharedPreferences.getString(SharedPreferencesKeys.appLanguageKey);
  }

  setAppTheme({bool? isDarkTheme}) {
    _sharedPreferences.setBool(
      SharedPreferencesKeys.appThemeKey,
      isDarkTheme ?? false,
    );
  }

  bool? getAppTheme() {
    return _sharedPreferences.getBool(SharedPreferencesKeys.appThemeKey);
  }

  setDataLocale({required List<String?>? data, required String? key}) {
    _sharedPreferences.setStringList(
      key ?? "",
      (data ?? [""]).whereType<String>().toList(),
    );
  }

  List<String?>? getDataLocale({String? key}) {
    return _sharedPreferences.getStringList(key ?? "");
  }
}
