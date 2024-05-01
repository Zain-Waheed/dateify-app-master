import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LANGUAGE_CODE = 'languageCode';
const String ENGLISH = 'en';
const String KOREAN = 'ko';
const String VIETNAM = 'zh';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs
      .setString(LANGUAGE_CODE, languageCode)
      .then((value) => print('prefs saved lang = $value'));
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? "en";
  print('prefs lang code = $languageCode');
  return _locale(languageCode);
}

Future<String> getLanguageCode() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? "en";
  return languageCode;
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, 'US');
      case KOREAN:
      return const Locale(KOREAN, 'KO');
      case VIETNAM:
      return const Locale(ENGLISH, 'VI');
    default:
      return const Locale(ENGLISH, "US");
  }
}
