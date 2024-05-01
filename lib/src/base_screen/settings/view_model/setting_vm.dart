

import 'dart:io';

import 'package:dateify_project/src/base_screen/home/model/group_model.dart';
import 'package:flutter/cupertino.dart';

class SettingVM extends ChangeNotifier {

  int settingPageIndex=0;
  //============================


  update(){
    notifyListeners();
  }
//===================================


}