import 'package:flutter/cupertino.dart';

import '../model/search_model.dart';


class SearchVM extends ChangeNotifier {

  String? searchOption="1";
  String? selectedOption="Global search";
  //--------
  int searchindex=0;
  //---------------
  List<DatumSearch> searchitems = [];

  update(){
    notifyListeners();
  }
//===================================
  //==========Fetch Groups=================


}