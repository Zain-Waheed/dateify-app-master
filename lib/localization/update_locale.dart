import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'locale_contants.dart';

bool isRTL = false;

class UpdateLocale {
  Future language(String languageCode, BuildContext? context) async {
    // final SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance();
    // sharedPreferences.getInt("lang");

    print(languageCode);
    Locale _temp;
    setLocale(languageCode);
    switch (languageCode) {
      case "en":
        _temp = Locale(languageCode, 'US');
        isRTL = false;
        Get.updateLocale(_temp);

        break;
      case "ko":
        _temp = Locale(languageCode, 'KO');
        isRTL = false;
        Get.updateLocale(_temp);
        break;
      case "zh":
        _temp = Locale(languageCode, 'VI');
        isRTL = false;
        Get.updateLocale(_temp);
        break;
      default:
        _temp = Locale(languageCode, 'US');
        isRTL = false;
        Get.updateLocale(_temp);
    }
    MyApp.setLocale(context!, _temp);
    return Future.value(true);
  }
}
