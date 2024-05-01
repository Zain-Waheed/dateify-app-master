import 'dart:io';

import 'package:dateify_project/src/base_screen/home/model/group_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/comment_model.dart';
import '../model/post_model.dart';

class HomeVM extends ChangeNotifier {

  List<GroupModel> groups=[];
  int pageindex=0;
  //============================
  final FocusNode focusNode = FocusNode();
  //============================
  int? parentCommentID;
  int? postID;
  bool isAnonymous = false;
 late Comment comment;
  //=============================
  GroupModel? groupModel;
  //=============================
  List<Datum> postitems = [];

  update(){
    notifyListeners();
  }
//===================================


}