

import 'package:flutter/cupertino.dart';

import '../../../models/user_model.dart';

class LandingVM extends ChangeNotifier {

  User? userModel;
  update(){
    notifyListeners();
  }




}