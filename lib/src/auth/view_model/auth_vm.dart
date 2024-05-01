import 'package:flutter/cupertino.dart';

import '../../../models/user_model.dart';


class AuthVM extends ChangeNotifier {

  User? userModel;
  //========Singup===============
  int? generatedOtp;
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  //========Singin===============
  update(){
    notifyListeners();
  }
}