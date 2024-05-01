import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../localization/update_locale.dart';

class BaseVM extends ChangeNotifier {
  int baseCurrentPage = 0;
  PageController?  basePageViewController = PageController();
  String? userID;
  bool? playSound=true;



  bool? statusShowNotifications;
  bool? statusSound;
  bool? statusVibrations;

  BaseVM(

      );
  update(){
    notifyListeners();
  }
  void setFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    notifyListeners();
  }
  updatePage(int index) {
    baseCurrentPage = index;
    notifyListeners();
  }


  UpdateLocale lang = UpdateLocale();
  int selectedLanguage = 0;
  onChangeLang(String langCode) {
    print('language changed');
    lang.language(langCode, Get.context).then((value) => notifyListeners());
  }

  onLanguageChanged() {

    if(selectedLanguage == 0)
    {
      onChangeLang('en');
    }else
      if(selectedLanguage==1)
      {
        onChangeLang('ko');
      }else
        if(selectedLanguage==2)
      {
        onChangeLang('zh');
      }
    notifyListeners();
  }
}
