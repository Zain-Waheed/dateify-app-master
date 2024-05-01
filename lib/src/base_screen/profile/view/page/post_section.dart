
import 'dart:convert';

import 'package:dateify_project/src/base_screen/home/model/post_model.dart';
import 'package:dateify_project/src/base_screen/home/view/post_view.dart';
import 'package:dateify_project/src/base_screen/profile/model/allMyPost_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../localization/app_localization.dart';
import '../../../../../../resources/app_colors.dart';
import '../../../../../../resources/app_images.dart';
import '../../../../../../resources/text_styles.dart';
import 'package:http/http.dart' as http;

import '../../../../../backend/api_request.dart';
import '../../../../../utils/helper.dart';
import '../../widgets/post_section_widget.dart';

class PostSection extends StatefulWidget {
  const PostSection({Key? key,}) : super(key: key);

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  //====Group Variables===========
  final postController = ScrollController();
  List<DatumAllMyPosts> postsitems = [];
  bool hasMorePosts = true;
  int postPage = 1;
  bool isLoadingPosts = false;
  //==============================
  @override
  void initState() {
    fetchMyPosts();
    postController.addListener(() {
      if (postController.position.maxScrollExtent == postController.offset) {
        fetchMyPosts();
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    //--------------------------
    postController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: postController,
        itemCount: postsitems.length + 1,
        itemBuilder: (context, index) {
          if (index < postsitems.length) {
            final itemPosts = postsitems[index];
            // return  ListTile(title: Text("${item.id}"));
            print("- Item Posts---${itemPosts.name}");
            return
              PostSectionWidget(datumAllMyPosts: itemPosts,);
          }
          else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: hasMorePosts
                    ? const CircularProgressIndicator()
                    : const Text('No More data to load'),
              ),
            );
          }
        }
    );
  }
  //---------------------------------------------------------------
  Future fetchMyPosts() async {
    if (isLoadingPosts) return;
    isLoadingPosts = true;
    try {
      bool isConnected = await checkInternet();
      if (!isConnected) {
        // ShowMessage.inDialog('No Internet Connection', true);
        Helper.ToastFlutter('No Internet Connection');
      } else {
        final url = Uri.parse('https://api.dateifyapp.com/api/v1/posts/my?&page=$postPage');
        var token = await Helper.Token();
        // final url=Uri.parse('http://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
        final response = await http.get(url, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        });
        if (response.statusCode == 200) {
          AllMyPostsModel allMyPostsModel =
          AllMyPostsModel.fromJson(jsonDecode(response.body));
          // final List newItems = allMyPostsModel.content.posts.data;
          setState(() {
            if (allMyPostsModel.content.groups.nextPageUrl != null) {
              postPage++;
              isLoadingPosts = false;
            } else {
              postPage = 1;
              hasMorePosts = false;
            }
            postsitems.addAll(allMyPostsModel.content.groups.data);
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
      print("*****Post Section API****eeeeeeeee**${e}");
    }
  }
}
