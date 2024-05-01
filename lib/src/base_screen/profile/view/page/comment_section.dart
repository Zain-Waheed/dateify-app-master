import 'dart:convert';

import 'package:dateify_project/src/auth/view/singup/personel_info.dart';
import 'package:dateify_project/src/base_screen/home/view/post_view.dart';
import 'package:dateify_project/src/base_screen/home/widget/ReplyWidget.dart';
import 'package:dateify_project/src/base_screen/profile/model/allMyComment_model.dart';
import 'package:dateify_project/src/base_screen/profile/widgets/AllCommnetsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../backend/api_request.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../utils/helper.dart';
import 'package:http/http.dart' as http;

import '../../../home/model/post_model.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({Key? key}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  //====Group Variables===========
  final commentController = ScrollController();
  List<DatumALlMyComments> commentsitems = [];
  bool hasMoreComments = true;
  int commentPage = 1;
  bool isLoadingComments = false;
  //==============================
  @override
  void initState() {
    fetchMyComments();
    commentController.addListener(() {
      if (commentController.position.maxScrollExtent ==
          commentController.offset) {
        fetchMyComments();
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    //--------------------------
    commentController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return ListView.builder(
      controller: commentController,
        itemCount: commentsitems.length + 1,
        itemBuilder: (context, index) {
          if (index < commentsitems.length) {
            final item = commentsitems[index];
            return AllCommentsWidget(
              datumALlMyComments: item,
            );
          } else {
            print("----Comments Index----${index}");
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: hasMoreComments
                    ? const CircularProgressIndicator()
                    : const Text('No More Comments'),
              ),
            );
          }
        });
  }

  //---------------------------------------------------------------
  Future fetchMyComments() async {
    if (isLoadingComments) return;
    isLoadingComments = true;
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
      } else {
        final url = Uri.parse(
            'https://api.dateifyapp.com/api/v1/posts/comments/all?&page=$commentPage');
        var token = await Helper.Token();
        // final url=Uri.parse('http://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
        final response = await http.get(url, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        });
        if (response.statusCode == 200) {
          AllMyCommentModel allMyCommentModel =
              AllMyCommentModel.fromJson(jsonDecode(response.body));
          setState(() {
            if (allMyCommentModel.content.groups.nextPageUrl != null) {
              commentPage++;
              isLoadingComments = false;
            } else {
              commentPage = 1;
              hasMoreComments = false;
            }
            commentsitems.addAll(allMyCommentModel.content.groups.data);
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("****Fetch My Comments *****eeeeeeeee**${e}");
    }
  }
}
